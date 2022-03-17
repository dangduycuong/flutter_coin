import 'package:dio/dio.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:flutter_coin/data/login/models/request/login_request.dart';
import 'package:flutter_coin/data/login/models/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../coin_detail/models/response/coin_detail_response.dart';

part 'coins_api.g.dart';

@RestApi()
abstract class ListCoinsApi {
  factory ListCoinsApi(Dio dio, {String baseUrl}) = _ListCoinsApi;

  @POST('/login')
  Future<LoginResponse> login(@Body() CoinRequest request);

  @GET('/coins')
  Future<ListCoinsResponse> getCoins(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Query('referenceCurrencyUuid') String referenceCurrencyUuid,
    @Query('timePeriod') String timePeriod,
    @Query('tiers') String tiers,
    @Query('orderBy') String orderBy,
    @Query('orderDirection') String orderDirection,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET('/coin/{uuid}')
  Future<CoinDetailResponseModel> getCoin(
    @Header('x-rapidapi-host') String host,
    @Header('x-rapidapi-key') String key,
    @Path('uuid') String uuid,
    @Query('referenceCurrencyUuid') String referenceCurrencyUuid,
    @Query('timePeriod') String timePeriod,
  );
}
