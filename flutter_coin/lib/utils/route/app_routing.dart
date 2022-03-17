import 'package:flutter/material.dart';
import 'package:flutter_coin/presentation/coin_detail/coinranking_route.dart';

import '../../data/coin_detail/models/response/coin_detail_item.dart';
import '../../data/coins/models/response/list_coins/coins.dart';
import '../../presentation/coin_detail/coin_detail_route.dart';
import '../../presentation/list_coins/list_coins_route.dart';

enum RouteDefine {
  listCoinsScreen,
  coinRankingWebViewScreen,
  coinDetailScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.listCoinsScreen.name: (_) => ListCoinsRoute.route,
      RouteDefine.coinRankingWebViewScreen.name: (_) =>
          CoinRankingRoute.route(data: settings.arguments as CoinDetailItem),
      RouteDefine.coinDetailScreen.name: (_) =>
          CoinDetailRoute.route(coin: settings.arguments as Coins),
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
