import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String userPhone;

  const UserEntity({
    required this.userName,
    required this.userPhone,
  });

  @override
  List<Object> get props => [
    userName,
    userPhone,
  ];
}

class CoinEntity extends Equatable {
  final String symbol;
  final String name;
  final String iconUrl;
  final String price;

  const CoinEntity({
    required this.symbol,
    required this.name,
    required this.iconUrl,
    required this.price,
  });

  @override
  List<Object> get props => [
    symbol,
    name,
    iconUrl,
    price,
  ];
}