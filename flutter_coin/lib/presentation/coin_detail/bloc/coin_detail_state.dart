part of 'coin_detail_bloc.dart';

abstract class CoinDetailState extends Equatable {
  const CoinDetailState();
}

class CoinDetailInitial extends CoinDetailState {
  @override
  List<Object> get props => [];
}

class LoadingCoinDetailState extends CoinDetailState {
  @override
  List<Object> get props => [];
}

class LoadCoinDetailErrorState extends CoinDetailState {
  final String error;

  const LoadCoinDetailErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class LoadCoinDetailSuccessState extends CoinDetailState {
  @override
  List<Object> get props => [];
}
