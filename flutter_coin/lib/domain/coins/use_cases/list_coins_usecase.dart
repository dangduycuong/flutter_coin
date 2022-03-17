import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:flutter_coin/data/login/models/request/login_request.dart';
import 'package:flutter_coin/data/login/models/response/login_response.dart';
import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coin_detail/models/response/coin_detail_response.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/request/list_coins/list_coins_params_request.dart';
import '../repositories/list_coins_repository.dart';

class CoinsUseCase {
  final CoinsRepository _repository;

  CoinsUseCase(this._repository);

  Future<LoginResponse> login(CoinRequest request) =>
      _repository.login(request);

  Future<ListCoinsResponse> getCoins(
          CoinsHeaderRequest header, ListCoinsParamsRequest params) =>
      _repository.getCoins(header, params);

  Future<CoinDetailResponseModel> getCoin(
          CoinsHeaderRequest header, CoinDetailParamsRequest params) =>
      _repository.getCoin(header, params);
}
