// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
//
// import '../../../coin_detail/models/response/coin_detail_response.dart';
//
// part 'coin_detail_api.g.dart';
//
// @RestApi()
// abstract class CoinDetailApi {
//   factory CoinDetailApi(Dio dio, {String baseUrl}) = _CoinDetailApi;
//
//   @GET('/coin')
//   Future<CoinDetailResponseModel> getCoin(
//     @Header('x-rapidapi-host') String host,
//     @Header('x-rapidapi-key') String key,
//     @Query('referenceCurrencyUuid') String referenceCurrencyUuid,
//     @Query('timePeriod') String timePeriod,
//   );
// }