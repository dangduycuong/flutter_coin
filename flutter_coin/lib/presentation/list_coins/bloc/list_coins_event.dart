part of 'list_coins_bloc.dart';

abstract class ListCoinsEvent extends Equatable {
  const ListCoinsEvent();
}

class LoginPressed extends ListCoinsEvent {
  final String userName;
  final String password;
  final bool isError;

  const LoginPressed(
    this.userName,
    this.password,
    this.isError,
  );

  @override
  List<Object> get props => [
        userName,
        password,
        isError,
      ];
}

class InitHiveEvent extends ListCoinsEvent {
  @override
  List<Object> get props => [];
}

class CoinLoadingEvent extends ListCoinsEvent {
  final bool isRefresh;

  const CoinLoadingEvent(this.isRefresh);

  @override
  List<Object> get props => [isRefresh];
}

class SearchCoinsSuggestionsEvent extends ListCoinsEvent {
  final String query;

  const SearchCoinsSuggestionsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class CoinRefreshEvent extends ListCoinsEvent {
  @override
  List<Object> get props => [];
}

class CoinLoadMoreEvent extends ListCoinsEvent {
  @override
  List<Object> get props => [];
}

class CoinSortEvent extends ListCoinsEvent {
  final CoinsViewFilter filter;

  const CoinSortEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class LoadFavoriteCoinsEvent extends ListCoinsEvent {
  @override
  List<Object> get props => [];
}

class AddFavoriteCoinEvent extends ListCoinsEvent {
  final Coins coin;

  const AddFavoriteCoinEvent(this.coin);

  @override
  List<Object> get props => [coin];
}

class DeleteFavoriteCoinEvent extends ListCoinsEvent {
  final String uuid;

  const DeleteFavoriteCoinEvent(this.uuid);

  @override
  List<Object?> get props => [uuid];
}

class SortFavoriteCoinsEvent extends ListCoinsEvent {
  final CoinsViewFilter filter;

  const SortFavoriteCoinsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class SearchCoinsInLocalEvent extends ListCoinsEvent {
  final String query;

  const SearchCoinsInLocalEvent(this.query);

  @override
  List<Object> get props => [query];
}
