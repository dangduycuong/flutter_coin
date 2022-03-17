import 'package:equatable/equatable.dart';

class CoinDetailEntity extends Equatable {
  final String uuid;
  final String symbol;
  final String name;

  const CoinDetailEntity({
    required this.uuid,
    required this.symbol,
    required this.name,
  });

  @override
  List<Object> get props => [
        uuid,
        symbol,
        name,
      ];
}
