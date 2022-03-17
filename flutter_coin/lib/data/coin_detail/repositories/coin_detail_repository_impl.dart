import '../../../domain/coin_detail/repositories/coin_detail_repository.dart';
import '../../coins/models/request/coins_header_request.dart';
import '../data_sources/remote/coin_detail_api.dart';
import '../models/request/coin_detail_params_request.dart';
import '../models/response/coin_detail_response.dart';

class CoinDetailRepositoryImpl implements CoinDetailRepository {
  final CoinDetailApi api;

  CoinDetailRepositoryImpl(this.api);

  @override
  Future<CoinDetailResponseModel> getCoin(
      CoinsHeaderRequest header, CoinDetailParamsRequest params) async {
    return await api.getCoin(
      header.host,
      header.key,
      params.referenceCurrencyUuid,
      params.timePeriod,
    );
  }
}
