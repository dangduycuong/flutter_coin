import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/coin_detail/models/request/coin_detail_params_request.dart';
import '../../../data/coin_detail/models/response/coin_detail_item.dart';
import '../../../data/coin_detail/models/response/coin_detail_response.dart';
import '../../../data/coins/models/request/coins_header_request.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/coins/use_cases/list_coins_usecase.dart';

part 'coin_detail_event.dart';

part 'coin_detail_state.dart';

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final CoinsUseCase coinDetailUseCase;
  CoinDetailItem coin = CoinDetailItem();

  CoinDetailBloc(this.coinDetailUseCase) : super(CoinDetailInitial()) {
    on<CoinDetailEvent>((event, emit) {});
    on<LoadDetailCoinEvent>(_getCoin);
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
        uuid: event.uuid,
        referenceCurrencyUuid: "yhjMzLPhuIDl",
        timePeriod: "24h",
      );
      CoinDetailResponseModel result =
          await coinDetailUseCase.getCoin(header, params);
      if (result.status != "success") {
        emit(const LoadCoinDetailErrorState("Failure"));
      } else {
        if (result.data?.coin != null) {
          coin = result.data!.coin!;
          emit(LoadCoinDetailSuccessState());
        }
      }
    } on ApiException catch (e) {
      emit(LoadCoinDetailErrorState(e.displayError));
    }
  }

  // String parseHtmlString() {
  //   final document = parse(coin.description);
  //   final String parsedString = parse(document.body.text).documentElement.text;
  //
  //   return parsedString;
  // }
}
