import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:hive/hive.dart';

import '../../../data/coins/models/local/local_coin.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/request/list_coins/list_coins_params_request.dart';
import '../../../data/coins/models/response/list_coins/coins.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/coins/use_cases/list_coins_usecase.dart';
import '../ui/list_coins_screen.dart';
import 'package:stream_transform/src/rate_limit.dart';
import 'package:stream_transform/src/switch.dart';

part 'list_coins_event.dart';

part 'list_coins_state.dart';

const _duration = Duration(milliseconds: 1200);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ListCoinsBloc extends Bloc<ListCoinsEvent, ListCoinsState> {
  final CoinsUseCase coinsUseCase;
  final int _limit = 20;
  int _start = 0;
  List<Coins> coins = <Coins>[];
  bool stopLoadMore = false;
  String _orderBy = "marketCap";
  String _orderDirection = "desc";
  List<Coins> listFavoriteCoins = [];
  List<Coins> sortFavoriteCoins = [];
  LocalCoinModel favoriteCoinItem = LocalCoinModel();
  late final Box box;
  String? searchText;

  ListCoinsBloc(this.coinsUseCase) : super(ListCoinsInitial()) {
    on<InitHiveEvent>(_hiveInit);
    on<CoinLoadingEvent>(_fetchCoins);
    on<CoinRefreshEvent>(_refreshCoins);
    on<CoinLoadMoreEvent>(_loadMoreCoins);
    on<CoinSortEvent>(_sortCoinBy);
    on<LoadFavoriteCoinsEvent>(_loadFavoriteCoins);
    on<DeleteFavoriteCoinEvent>(_deleteFavoriteCoin);
    on<AddFavoriteCoinEvent>(_addFavoriteCoin);
    on<SortFavoriteCoinsEvent>(_sortFavoriteCoins);
    on<SearchCoinsSuggestionsEvent>(_searchCoinsSuggestions,
        transformer: debounce(_duration));
    on<SearchCoinsInLocalEvent>(_searchCoinsLocal);
  }

  void _hiveInit(InitHiveEvent event, Emitter<ListCoinsState> emit) {
    box = Hive.box('favoriteCoinsBox');
  }

  void _fetchCoins(CoinLoadingEvent event, Emitter<ListCoinsState> emit) async {
    try {
      emit(CoinLoadingState(isRefresh: event.isRefresh));
      CoinsHeaderRequest header = CoinsHeaderRequest(
        host: "coinranking1.p.rapidapi.com",
        key: "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
      );
      ListCoinsParamsRequest params = ListCoinsParamsRequest(
        referenceCurrencyUuid: "yhjMzLPhuIDl",
        timePeriod: "24h",
        tiers: "1",
        orderBy: _orderBy,
        search: searchText,
        orderDirection: _orderDirection,
        limit: _limit,
        offset: _start,
      );
      ListCoinsResponse result = await coinsUseCase.getCoins(header, params);
      if (result.status != "success") {
        emit(const CoinLoadErrorState("Failure"));
      } else {
        if (result.data?.coins != null) {
          result.data?.coins?.forEach((element) {
            element.doubleSparkline =
                element.sparkline?.map((e) => double.parse(e ?? '0')).toList();
          });
          coins += (result.data!.coins!);
          if (result.data?.coins?.isEmpty == true) {
            stopLoadMore = true;
          }
          emit(CoinLoadSuccessState());
        } else {
          stopLoadMore = true;
        }
      }
    } on ApiException catch (e) {
      emit(CoinLoadErrorState(e.displayError));
    }
  }

  void _searchCoinsSuggestions(
      SearchCoinsSuggestionsEvent event, Emitter<ListCoinsState> emit) async {
    searchText = event.query;
    _start = 0;
    coins.clear();
    stopLoadMore = false;
    add(CoinRefreshEvent());
  }

  void _searchCoinsLocal(
      SearchCoinsInLocalEvent event, Emitter<ListCoinsState> emit) {
    emit(LoadingListFavoriteState());
    if (event.query.isEmpty) {
      sortFavoriteCoins = listFavoriteCoins;
    } else {
      sortFavoriteCoins = listFavoriteCoins.where((element) {
        String name = (element.name ?? '').toLowerCase();
        String symbol = (element.symbol ?? '').toLowerCase();
        String key = event.query.toLowerCase();
        return name.contains(key) || symbol.contains(key);
      }).toList();
    }

    emit(LoadListFavoriteSuccessState());
  }

  void _refreshCoins(CoinRefreshEvent event, Emitter<ListCoinsState> emit) {
    _start = 0;
    coins.clear();
    stopLoadMore = false;
    add(const CoinLoadingEvent(isRefresh: true));
  }

  void _loadMoreCoins(CoinLoadMoreEvent event, Emitter<ListCoinsState> emit) {
    if (stopLoadMore == false) {
      _start += _limit;
      add(const CoinLoadingEvent(isRefresh: false));
    }
  }

  void _sortFavoriteCoins(
      SortFavoriteCoinsEvent event, Emitter<ListCoinsState> emit) async {
    emit(LoadingListFavoriteState());

    sortFavoriteCoins = listFavoriteCoins;
    switch (event.filter) {
      case CoinsViewFilter.marketCap:
        sortFavoriteCoins = listFavoriteCoins;
        sortFavoriteCoins.reversed.toList();
        break;
      case CoinsViewFilter.increment:
        sortFavoriteCoins.sort((a, b) => double.parse(a.price ?? '0')
            .compareTo(double.parse(b.price ?? '0')));
        break;
      case CoinsViewFilter.decrement:
        sortFavoriteCoins.sort((a, b) => double.parse(b.price ?? '0')
            .compareTo(double.parse(a.price ?? '0')));
        break;
      case CoinsViewFilter.greatChange:
        sortFavoriteCoins.sort((a, b) => double.parse(b.change ?? '0')
            .compareTo(double.parse(a.change ?? '0')));

        break;
      case CoinsViewFilter.badChange:
        sortFavoriteCoins.sort((a, b) => double.parse(a.change ?? '0')
            .compareTo(double.parse(b.change ?? '0')));
        break;
    }
    await Future.delayed(const Duration(seconds: 1), () {});
    emit(LoadListFavoriteSuccessState());
  }

  void _sortCoinBy(CoinSortEvent event, Emitter<ListCoinsState> emit) {
    _orderDirection = "desc";
    switch (event.filter) {
      case CoinsViewFilter.marketCap:
        _orderBy = "marketCap";
        break;
      case CoinsViewFilter.increment:
        _orderBy = "price";
        _orderDirection = "asc";
        break;
      case CoinsViewFilter.decrement:
        _orderBy = "price";
        _orderDirection = "desc";
        break;
      case CoinsViewFilter.greatChange:
        _orderBy = 'change';
        _orderDirection = "desc";
        break;
      case CoinsViewFilter.badChange:
        _orderBy = 'change';
        _orderDirection = "asc";
        break;
    }
    _start = 0;
    coins = [];
    stopLoadMore = false;
    add(const CoinLoadingEvent(isRefresh: true));
  }

  void _loadFavoriteCoins(
      LoadFavoriteCoinsEvent event, Emitter<ListCoinsState> emit) {
    emit(LoadingListFavoriteState());
    listFavoriteCoins.clear();
    sortFavoriteCoins.clear();
    if (box.length > 0) {
      for (int index = 0; index < box.length; index++) {
        final LocalCoinModel local = box.getAt(index) as LocalCoinModel;
        Coins coin = Coins(
          uuid: local.uuid,
          iconUrl: local.iconUrl,
          name: local.name,
          symbol: local.symbol,
          price: local.price,
          sparkline: local.sparkline,
          color: local.color,
          change: local.change,
        );

        listFavoriteCoins.add(coin);
      }
    }
    sortFavoriteCoins = listFavoriteCoins;
    emit(LoadListFavoriteSuccessState());
  }

  void _addFavoriteCoin(
      AddFavoriteCoinEvent event, Emitter<ListCoinsState> emit) {
    String uuid = event.coin.uuid ?? '';
    listFavoriteCoins.add(event.coin);
    LocalCoinModel coin = LocalCoinModel();
    coin.uuid = uuid;
    coin.iconUrl = event.coin.iconUrl;
    coin.name = event.coin.name;
    coin.symbol = event.coin.symbol;
    coin.price = event.coin.price;
    coin.sparkline = event.coin.sparkline;
    coin.color = event.coin.color;
    coin.change = event.coin.change;

    box.add(coin);
  }

  void _deleteFavoriteCoin(
      DeleteFavoriteCoinEvent event, Emitter<ListCoinsState> emit) {
    int index = getIndexOfItem(event.uuid);
    box.deleteAt(index);
    listFavoriteCoins.removeWhere((item) => item.uuid == event.uuid);
    // emit(ReloadData());
  }

  int getIndexOfItem(String uuid) {
    int result = 0;
    for (int index = 0; index < box.length; index++) {
      final LocalCoinModel coin = box.getAt(index) as LocalCoinModel;
      if (coin.uuid == uuid) {
        result = index;
        break;
      }
    }
    return result;
  }

  bool findFavoriteItem(Coins coin) {
    if (box.length > 0) {
      for (int index = 0; index < box.length; index++) {
        final LocalCoinModel local = box.getAt(index) as LocalCoinModel;
        if (coin.uuid == local.uuid) {
          return true;
        }
      }
    }

    return false;
  }
}
