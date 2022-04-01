import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coin_detail/models/response/coin_detail_response.dart';
import '../../../data/coins/models/request/coin_ohlc_data/coin_ohlc_data_request_params.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/request/list_coins/list_coins_params_request.dart';
import '../../../data/coins/models/response/coin_ohlc_data/coin_ohlc_data_response.dart';
import '../repositories/coins_repository.dart';

class CoinsUseCase {
  final CoinsRepository _repository;

  CoinsUseCase(this._repository);

  Future<ListCoinsResponse> getCoins(
          CoinsHeaderRequest header, ListCoinsParamsRequest params) =>
      _repository.getCoins(header, params);

  Future<CoinDetailResponseModel> getCoin(CoinsHeaderRequest header,
          String uuid, CoinDetailParamsRequest params) =>
      _repository.getCoin(header, uuid, params);

  Future<CoinOHLCDataResponse> getCoinOHLCData(CoinsHeaderRequest header,
          String uuid, CoinOHLCDataRequestParams params) =>
      _repository.getCoinOHLCData(header, uuid, params);
}
