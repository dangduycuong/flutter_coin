import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coin_detail/models/response/coin_detail_item.dart';
import '../../../data/coin_detail/models/response/coin_detail_response.dart';
import '../../../data/coins/models/request/coin_ohlc_data/coin_ohlc_data_request_params.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/coins/models/response/coin_ohlc_data/coin_ohlc_data_response.dart';
import '../../../data/coins/models/response/coin_ohlc_data/ohlc.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/coins/use_cases/list_coins_usecase.dart';
import '../../../utils/external_package/candlesticks/lib/candlesticks.dart';
import '../../../utils/multi-languages/multi_languages_utils.dart';

part 'coin_detail_event.dart';

part 'coin_detail_state.dart';

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final CoinsUseCase coinDetailUseCase;
  CoinDetailItem coin = const CoinDetailItem();
  List<Candle> candles = [];

  CoinDetailBloc(this.coinDetailUseCase) : super(CoinDetailInitial()) {
    on<CoinDetailEvent>((event, emit) {});
    on<LoadDetailCoinEvent>(_getCoin);
    on<GetCoinOHLCDataEvent>(_getCoinOHLCData);
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
          add(GetCoinOHLCDataEvent());
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinDetailErrorState(e.displayError));
    }
  }

  void _getCoinOHLCData(
      GetCoinOHLCDataEvent event, Emitter<CoinDetailState> emit) async {
    try {
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
        emit(const LoadCoinDetailErrorState("Failure"));
      } else {
        if (result.data?.ohlc != null) {
          candles.clear();
          _settingDataChart(ohlcList: result.data?.ohlc ?? []);
          emit(LoadCoinDetailSuccessState());
        } else {
          emit(const LoadCoinDetailErrorState("Data null"));
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinDetailErrorState(e.displayError));
    }
  }

  DateTime _parseStringToDateTime(String dateString, String format) {
    return DateFormat(format).parse(dateString);
  }

  String _convertIntToDateTime(int timeStamp) {
    final dateFormat = DateFormat('dd-MM-yyyy hh:mm a');
    return dateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));
  }

  void _settingDataChart({required List<OHLCItem> ohlcList}) {
    for (final element in ohlcList) {
      String dateString = _convertIntToDateTime(element.startingAt ?? 0);
      DateTime time = _parseStringToDateTime(dateString, 'dd-MM-yyyy hh:mm a');

      double high = double.parse(element.high ?? '0');

      double low = double.parse(element.low ?? '0');

      double open = double.parse(element.open ?? '0');

      double close = double.parse(element.close ?? '0');

      double avg = double.parse(element.avg ?? '0');
      final Candle item = Candle(
        date: time,
        high: high,
        low: low,
        open: open,
        close: close,
        volume: avg,
      );

      candles.add(item);
    }
  }
}
