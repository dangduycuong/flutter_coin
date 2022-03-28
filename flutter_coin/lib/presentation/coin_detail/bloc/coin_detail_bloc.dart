import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coin_detail/models/response/coin_detail_item.dart';
import '../../../data/coin_detail/models/response/coin_detail_response.dart';
import '../../../data/coins/models/request/coin_ohlc_data/coin_ohlc_data_request_params.dart';
import '../../../data/coins/models/request/coin_price_history/coin_price_history_request_params.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/response/coin_ohlc_data/coin_ohlc_data_response.dart';
import '../../../data/coins/models/response/coin_ohlc_data/ohlc.dart';
import '../../../data/coins/models/response/coin_price_history/coin_price_history.dart';
import '../../../data/coins/models/response/coin_price_history/coin_price_history_response.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/coins/use_cases/list_coins_usecase.dart';

part 'coin_detail_event.dart';

part 'coin_detail_state.dart';

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final CoinsUseCase coinDetailUseCase;
  CoinDetailItem coin = const CoinDetailItem();
  List<CoinPriceHistory> coinPriceHistories = [];
  List<OHLCItem> ohlcList = [];

  CoinDetailBloc(this.coinDetailUseCase) : super(CoinDetailInitial()) {
    on<CoinDetailEvent>((event, emit) {});
    on<LoadDetailCoinEvent>(_getCoin);
    // on<GetCoinPriceHistoryEvent>(_getCoinPriceHistory);
    on<GetCoinPriceHistoryEvent>(_getCoinOHLCData);
  }

  void _getCoin(
      LoadDetailCoinEvent event, Emitter<CoinDetailState> emit) async {
    try {
      emit(LoadingCoinDetailState());
      CoinsHeaderRequest header = CoinsHeaderRequest(
        host: "coinranking1.p.rapidapi.com",
        key: "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
      );
      CoinDetailParamsRequest params = CoinDetailParamsRequest(
        referenceCurrencyUuid: "yhjMzLPhuIDl",
        timePeriod: "24h",
      );
      CoinDetailResponseModel result =
          await coinDetailUseCase.getCoin(header, event.uuid, params);
      if (result.status != "success") {
        emit(const LoadCoinDetailErrorState("Failure"));
      } else {
        if (result.data?.coin != null) {
          coin = result.data!.coin!;
          ohlcList.clear();
          emit(LoadCoinDetailSuccessState());
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinDetailErrorState(e.displayError));
    }
  }

  void _getCoinPriceHistory(
      GetCoinPriceHistoryEvent event, Emitter<CoinDetailState> emit) async {
    try {
      emit(LoadingCoinPriceHistoryState());
      CoinsHeaderRequest header = CoinsHeaderRequest(
        host: "coinranking1.p.rapidapi.com",
        key: "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
      );
      String uuid = coin.uuid ?? '';
      CoinPriceHistoryRequestParams params = CoinPriceHistoryRequestParams(
        referenceCurrencyUuid: "yhjMzLPhuIDl",
        timePeriod: "24h",
      );
      CoinPriceHistoryResponse result =
          await coinDetailUseCase.getCoinPriceHistory(header, uuid, params);
      if (result.status != "success") {
        emit(const LoadCoinPriceHistoryErrorState("Failure"));
      } else {
        if (result.data?.history != null) {
          coinPriceHistories = (result.data?.history ?? []).reversed.toList();

          emit(LoadCoinPriceHistorySuccessState());
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinPriceHistoryErrorState(e.displayError));
    }
  }

  void _getCoinOHLCData(
      GetCoinPriceHistoryEvent event, Emitter<CoinDetailState> emit) async {
    try {
      emit(LoadingCoinPriceHistoryState());
      CoinsHeaderRequest header = CoinsHeaderRequest(
        host: "coinranking1.p.rapidapi.com",
        key: "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa",
      );
      String uuid = coin.uuid ?? '';
      CoinOHLCDataRequestParams params = CoinOHLCDataRequestParams(
        referenceCurrencyUuid: "yhjMzLPhuIDl",
        timePeriod: "day", //one of minute, hour, 8hours, day, week, month
      );
      CoinOHLCDataResponse result =
          await coinDetailUseCase.getCoinOHLCData(header, uuid, params);
      if (result.status != "success") {
        emit(const LoadCoinPriceHistoryErrorState("Failure"));
      } else {
        if (result.data?.ohlc != null) {
          // ohlcList = (result.data?.ohlc ?? []).reversed.toList();
          ohlcList = result.data?.ohlc ?? [];

          emit(LoadCoinPriceHistorySuccessState());
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinPriceHistoryErrorState(e.displayError));
    }
  }
}
