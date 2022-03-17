import 'package:flutter_coin/data/coin_detail/models/request/coin_detail_params_request.dart';
import 'package:flutter_coin/data/coin_detail/models/response/coin_detail_response.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import 'package:flutter_coin/data/login/models/request/login_request.dart';
import 'package:flutter_coin/data/login/models/response/login_response.dart';
import '../../../domain/coins/repositories/list_coins_repository.dart';
import '../../coins/data_sources/remote/coins_api.dart';
import '../../coins/models/request/coins_header_request.dart';
import '../../coins/models/request/list_coins/list_coins_params_request.dart';

class LoginRepositoryImpl implements CoinsRepository {
  final ListCoinsApi api;

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(CoinRequest request) async {
    await api.login(request);
    // await api
    //     .login(request)
    //     .catchError((e, stack) => throw ApiException.error(e, stack));
    await Future.delayed(const Duration(seconds: 3));
    return const LoginResponse(
      userName: "UserName",
      phone: "phone",
      email: "email",
      createdAt: '',
    );
  }

  Future<ListCoinsResponse> getCoins(
      CoinsHeaderRequest header, ListCoinsParamsRequest params) async {
    return await api.getCoins(
      header.host,
      header.key,
      params.referenceCurrencyUuid,
      params.timePeriod,
      params.tiers,
      params.orderBy,
      params.orderDirection,
      params.limit,
      params.offset,
    );
  }

  @override
  Future<CoinDetailResponseModel> getCoin(
      CoinsHeaderRequest header, CoinDetailParamsRequest params) async {
    return await api.getCoin(
      header.host,
      header.key,
      params.uuid,
      params.referenceCurrencyUuid,
      params.timePeriod,
    );
  }
}
