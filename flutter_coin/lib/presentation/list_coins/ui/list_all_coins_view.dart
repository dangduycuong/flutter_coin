import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/route/app_routing.dart';
import '../../common/display_item_coin.dart';
import '../../common/loading_data.dart';
import '../../common/loading_list_coin.dart';
import '../bloc/list_coins_bloc.dart';

class ListAllCoinsView extends StatefulWidget {
  const ListAllCoinsView({Key? key}) : super(key: key);

  @override
  _ListAllCoinsViewState createState() => _ListAllCoinsViewState();
}

class _ListAllCoinsViewState extends State<ListAllCoinsView> {
  late ListCoinsBloc _bloc;
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    _bloc = context.read<ListCoinsBloc>();
    _bloc.add(InitHiveEvent());
    _bloc.add(const CoinLoadingEvent(true));

    super.initState();
  }

  Widget _displayListCoin() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) {
        final coin = _bloc.coins[index];

        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pushNamed(context, RouteDefine.coinDetailScreen.name,
                arguments: coin);
          },
          child: displayOneItemCoin(
            coin: coin,
            context: context,
            sparkline: coin.doubleSparkline ?? [],
            isFavorite: _bloc.findFavoriteItem(coin),
            onchange: (value) {
              if (value) {
                _bloc.add(AddFavoriteCoinEvent(coin));
              } else {
                _bloc.add(DeleteFavoriteCoinEvent(coin.uuid ?? ''));
              }
              setState(() {});
            },
          ),
        );
      },
      itemCount: _bloc.coins.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListCoinsBloc, ListCoinsState>(
      builder: (context, state) {
        if (state is CoinLoadingState) {
          if (state.isRefresh) {
            return const LoadingListCoin();
          }
        }

        if (state is CoinLoadSuccessState && _bloc.coins.isEmpty) {
          return loadingData(context, 'Data not found');
        }
        if (state is CoinLoadErrorState) {
          return loadingData(context, state.errorMessage);
        }
        return SmartRefresher(
          controller: _controller,
          child: _displayListCoin(),
          enablePullUp: !(_bloc.stopLoadMore),
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _controller.refreshCompleted();
            _bloc.add(CoinRefreshEvent());
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _controller.loadComplete();
            _bloc.add(CoinLoadMoreEvent());
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
