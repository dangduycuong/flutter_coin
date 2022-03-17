part of 'list_coins_bloc.dart';

abstract class ListCoinsState extends Equatable {
  const ListCoinsState();
}

class ListCoinsInitial extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends ListCoinsState {
  final String errorMessage;

  const LoginErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

class LoginLoadingState extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class CoinLoadingState extends ListCoinsState {
  final bool isRefresh;

  const CoinLoadingState({required this.isRefresh});

  @override
  List<Object> get props => [isRefresh];
}

class CoinLoadErrorState extends ListCoinsState {
  final String errorMessage;

  const CoinLoadErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CoinLoadSuccessState extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class LoadingListFavoriteState extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class LoadListFavoriteSuccessState extends ListCoinsState {
  @override
  List<Object> get props => [];
}

class AddFavoriteSuccessState extends ListCoinsState {
  @override
  List<Object> get props => [];
}