import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:hive/hive.dart';

import '../../../data/coins/models/local/local_coin.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/request/list_coins/list_coins_params_request.dart';
import '../../../data/coins/models/response/list_coins/coins.dart';
import '../../../data/login/models/request/login_request.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/coins/use_cases/list_coins_usecase.dart';
import '../ui/list_coins_screen.dart';

part 'list_coins_event.dart';

part 'list_coins_state.dart';

class ListCoinsBloc extends Bloc<ListCoinsEvent, ListCoinsState> {
  final CoinsUseCase coinsUseCase;
  final int _limit = 20;
  int _start = 0;
  List<Coins> coins = <Coins>[];
  bool stopLoadMore = true;
  String _orderBy = "marketCap";
  String _orderDirection = "desc";
  List<LocalCoinModel> listUUIDFavoriteCoins = [];
  List<Coins> listFavoriteCoins = [];
  LocalCoinModel favoriteCoinItem = LocalCoinModel();
  late final Box box;

  ListCoinsBloc(this.coinsUseCase) : super(ListCoinsInitial()) {
    on<InitHiveEvent>(_hiveInit);
    on<CoinLoadingEvent>(_fetchCoins);
    on<CoinRefreshEvent>(_refreshCoins);
    on<CoinLoadMoreEvent>(_loadMoreCoins);
    on<CoinSortEvent>(_sortCoinBy);
    on<LoadFavoriteCoinsEvent>(_loadFavoriteCoins);
    on<DeleteFavoriteCoinEvent>(_deleteFavoriteCoin);
    on<AddFavoriteCoinEvent>(_addFavoriteCoin);
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
        orderDirection: _orderDirection,
        limit: _limit,
        offset: _start,
      );
      ListCoinsResponse result = await coinsUseCase.getCoins(header, params);
      if (result.status != "success") {
        emit(const CoinLoadErrorState("Failure"));
      } else {
        if (result.data?.coins != null) {
          coins += (result.data!.coins!);
          emit(CoinLoadSuccessState());
        } else {
          stopLoadMore = true;
        }
      }
    } on ApiException catch (e) {
      emit(CoinLoadErrorState(e.displayError));
    }
  }

  void _refreshCoins(CoinRefreshEvent event, Emitter<ListCoinsState> emit) {
    _start = 0;
    coins = [];
    stopLoadMore = false;
    add(const CoinLoadingEvent(true));
  }

  void _loadMoreCoins(CoinLoadMoreEvent event, Emitter<ListCoinsState> emit) {
    if (stopLoadMore == false) {
      _start += _limit;
      add(const CoinLoadingEvent(false));
    }
  }

  void _sortCoinBy(CoinSortEvent event, Emitter<ListCoinsState> emit) {
    _orderDirection = "desc";
    switch (event.filter) {
      case CoinsViewFilter.marketCap:
        _orderBy = "marketCap";
        break;
      case CoinsViewFilter.price_increment:
        _orderBy = "price";
        _orderDirection = "asc";
        break;
      case CoinsViewFilter.price_decrement:
        _orderBy = "price";
        _orderDirection = "desc";
        break;
      case CoinsViewFilter.volume24h:
        _orderBy = "24hVolume";
        break;
      case CoinsViewFilter.change:
        _orderBy = "change";
        break;
      case CoinsViewFilter.listedAt:
        _orderBy = "listedAt";
        break;
    }
    _start = 0;
    coins = [];
    stopLoadMore = false;
    add(const CoinLoadingEvent(true));
  }

  void _loadFavoriteCoins(
      LoadFavoriteCoinsEvent event, Emitter<ListCoinsState> emit) async {
    emit(LoadingListFavoriteState());
    listFavoriteCoins = [];
    for (int index = 0; index < box.length; index++) {
      final LocalCoinModel local = box.getAt(index) as LocalCoinModel;
      Coins coin = coins.firstWhere((item) {
        return (item.uuid == local.uuid);
      });
      listFavoriteCoins.add(coin);
    }
    emit(LoadListFavoriteSuccessState());
  }

  void _addFavoriteCoin(
      AddFavoriteCoinEvent event, Emitter<ListCoinsState> emit) {
    String uuid = event.coin.uuid ?? '';
    listFavoriteCoins.add(event.coin);
    box.add(uuid);
  }

  void _deleteFavoriteCoin(
      DeleteFavoriteCoinEvent event, Emitter<ListCoinsState> emit) {
    int index = getIndexOfItem(event.uuid);
    box.deleteAt(index);
    listUUIDFavoriteCoins.removeAt(index);
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
    for (int index = 0; index < box.length; index++) {
      final LocalCoinModel local = box.getAt(index) as LocalCoinModel;
      if (coin.uuid == local.uuid) {
        return true;
      }
    }

    return false;
  }
}
