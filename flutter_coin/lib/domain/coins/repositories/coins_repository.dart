import 'package:flutter_coin/data/coin_detail/models/response/coin_detail_response.dart';

import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coins/models/request/coin_ohlc_data/coin_ohlc_data_request_params.dart';
import '../../../data/coins/models/request/coin_price_history/coin_price_history_request_params.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/request/list_coins/list_coins_params_request.dart';
import '../../../data/coins/models/request/list_coins/search_suggestions_request_params.dart';
import '../../../data/coins/models/response/coin_ohlc_data/coin_ohlc_data_response.dart';
import '../../../data/coins/models/response/coin_price_history/coin_price_history_response.dart';
import '../../../data/coins/models/response/list_coins/list_coins_response.dart';

abstract class CoinsRepository {
  Future<ListCoinsResponse> getCoins(
      CoinsHeaderRequest header, ListCoinsParamsRequest params);

  Future<CoinDetailResponseModel> getCoin(
      CoinsHeaderRequest header, String uuid, CoinDetailParamsRequest params);

  Future<ListCoinsResponse> searchCoinsSuggestions(
      CoinsHeaderRequest header, SearchSuggestionsRequestParams params);

  Future<CoinPriceHistoryResponse> getCoinPriceHistory(
      CoinsHeaderRequest header, String uuid, CoinPriceHistoryRequestParams params);

  Future<CoinOHLCDataResponse> getCoinOHLCData(
      CoinsHeaderRequest header, String uuid, CoinOHLCDataRequestParams params);
}
