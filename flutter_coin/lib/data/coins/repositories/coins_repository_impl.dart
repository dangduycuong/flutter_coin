import 'package:flutter_coin/data/coin_detail/models/request/coin_detail_params_request.dart';
import 'package:flutter_coin/data/coin_detail/models/response/coin_detail_response.dart';
import 'package:flutter_coin/data/coins/models/request/coin_ohlc_data/coin_ohlc_data_request_params.dart';
import 'package:flutter_coin/data/coins/models/response/coin_ohlc_data/coin_ohlc_data_response.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import '../../../domain/coins/repositories/coins_repository.dart';
import '../../coins/data_sources/remote/coins_api.dart';
import '../../coins/models/request/coins_header_request.dart';
import '../../coins/models/request/list_coins/list_coins_params_request.dart';

class CoinsRepositoryImpl implements CoinsRepository {
  final CoinsApi api;

  CoinsRepositoryImpl(this.api);

  @override
  Future<ListCoinsResponse> getCoins(
      CoinsHeaderRequest header, ListCoinsParamsRequest params) async {
    return await api.getCoins(
      header.host,
      header.key,
      params.toJson(),
    );
  }

  @override
  Future<CoinDetailResponseModel> getCoin(CoinsHeaderRequest header,
      String uuid, CoinDetailParamsRequest params) async {
    return await api.getCoin(
      header.host,
      header.key,
      uuid,
      params.toJson(),
    );
  }

  @override
  Future<CoinOHLCDataResponse> getCoinOHLCData(CoinsHeaderRequest header,
      String uuid, CoinOHLCDataRequestParams params) async {
    return await api.getCoinOHLCData(
        header.host, header.key, uuid, params.toJson());
  }
}
