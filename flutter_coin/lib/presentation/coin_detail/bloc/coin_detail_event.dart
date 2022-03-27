part of 'coin_detail_bloc.dart';

abstract class CoinDetailEvent extends Equatable {
  const CoinDetailEvent();
}

class LoadDetailCoinEvent extends CoinDetailEvent {
  final String uuid;

  const LoadDetailCoinEvent(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

class GetCoinPriceHistoryEvent extends CoinDetailEvent {
  @override
  List<Object?> get props => [];
}

class IMissYouEvent extends CoinDetailEvent {
  @override
  List<Object?> get props => [];
}