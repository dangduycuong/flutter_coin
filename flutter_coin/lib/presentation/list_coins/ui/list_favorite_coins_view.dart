import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../utils/route/app_routing.dart';
import '../../common/display_item_coin.dart';
import '../../common/loading_data.dart';
import '../../common/loading_list_coin.dart';
import '../bloc/list_coins_bloc.dart';

class ListFavoriteCoinsView extends StatefulWidget {
  const ListFavoriteCoinsView({Key? key}) : super(key: key);

  @override
  _ListFavoriteCoinsViewState createState() => _ListFavoriteCoinsViewState();
}

class _ListFavoriteCoinsViewState extends State<ListFavoriteCoinsView> {
  late ListCoinsBloc _bloc;
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    _bloc = context.read<ListCoinsBloc>();
    _bloc.add(InitHiveEvent());
    _bloc.add(LoadFavoriteCoinsEvent());
    super.initState();
  }

  Widget _displayListCoin() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: false,
      itemBuilder: (context, index) {
        final coin = _bloc.sortFavoriteCoins[index];
        final List<double> sparkline = <double>[];
        if (coin.sparkline != null) {
          for (final element in coin.sparkline!) {
            double item = double.parse(element);
            sparkline.add(item);
          }
        }
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteDefine.coinDetailScreen.name,
                arguments: coin);
          },
          child: displayItemCoin(
            coin: coin,
            context: context,
            sparkline: sparkline,
            isFavorite: true,
            onchange: (value) {
              _bloc.add(DeleteFavoriteCoinEvent(coin.uuid ?? ''));
              setState(() {});
            },
          ),
        );
      },
      itemCount: _bloc.sortFavoriteCoins.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListCoinsBloc, ListCoinsState>(
      builder: (context, state) {
        if (state is LoadingListFavoriteState) {
          return const LoadingListCoin();
        }

        if (state is LoadListFavoriteSuccessState &&
            _bloc.sortFavoriteCoins.isEmpty) {
          return loadingData(context, 'Data not found');
        }
        return SmartRefresher(
          controller: _controller,
          child: _displayListCoin(),
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _controller.refreshCompleted();
            _bloc.add(LoadFavoriteCoinsEvent());
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _controller.loadComplete();
          },
        );
      },
      listener: (context, state) {},
    );
  }
}