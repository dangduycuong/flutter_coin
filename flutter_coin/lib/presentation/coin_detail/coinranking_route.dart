import 'package:flutter/cupertino.dart';
import 'package:flutter_coin/presentation/coin_detail/ui/coinranking_screen.dart';

import '../../data/coins/models/response/list_coins/coins.dart';

class CoinRankingRoute {
  static Widget route({required Coins data}) => CoinRankingWebViewScreen(
        coin: data,
      );
}
