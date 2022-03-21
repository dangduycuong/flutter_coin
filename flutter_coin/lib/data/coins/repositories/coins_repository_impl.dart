import 'package:flutter_coin/data/coin_detail/models/request/coin_detail_params_request.dart';
import 'package:flutter_coin/data/coin_detail/models/response/coin_detail_response.dart';
import 'package:flutter_coin/data/coins/models/request/coin_price_history/coin_price_history_request_params.dart';
import 'package:flutter_coin/data/coins/models/request/list_coins/search_suggestions_request_params.dart';
import 'package:flutter_coin/data/coins/models/response/coin_price_history/coin_price_history_response.dart';
import 'package:flutter_coin/data/coins/models/response/list_coins/list_coins_response.dart';
import '../../../domain/coins/repositories/list_coins_repository.dart';
import '../../coins/data_sources/remote/coins_api.dart';
import '../../coins/models/request/coins_header_request.dart';
import '../../coins/models/request/list_coins/list_coins_params_request.dart';

class CoinsRepositoryImpl implements CoinsRepository {
  final ListCoinsApi api;

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

  @override
  Future<ListCoinsResponse> searchCoinsSuggestions(
      CoinsHeaderRequest header, SearchSuggestionsRequestParams params) async {
    return await api.searchCoinsSuggestions(
        header.host, header.key, params.toJson());
  }

  @override
  Future<CoinPriceHistoryResponse> getCoinPriceHistory(
      CoinsHeaderRequest header,
      String uuid,
      CoinPriceHistoryRequestParams params) async {
    return await api.getCoinPriceHistory(
        header.host, header.key, uuid, params.toJson());
  }
}
