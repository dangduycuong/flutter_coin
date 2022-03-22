import 'package:dio/dio.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../coin_detail/models/response/coin_detail_response.dart';
import '../../models/response/coin_price_history/coin_price_history_response.dart';

part 'coins_api.g.dart';

@RestApi()
abstract class CoinsApi {
  factory CoinsApi(Dio dio, {String baseUrl}) = _CoinsApi;

  @GET('/coins')
  Future<ListCoinsResponse> getCoins(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Queries() Map<String, dynamic> queries,
  );

  @GET('/coin/{uuid}')
  Future<CoinDetailResponseModel> getCoin(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Path('uuid') String uuid,
    @Queries() Map<String, dynamic> queries,
  );

  @GET('/search-suggestions')
  Future<ListCoinsResponse> searchCoinsSuggestions(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Queries() Map<String, dynamic> queries,
  );

  @GET('/coin/{uuid}/history')
  Future<CoinPriceHistoryResponse> getCoinPriceHistory(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Path('uuid') String uuid,
    @Queries() Map<String, dynamic> queries,
  );
}
