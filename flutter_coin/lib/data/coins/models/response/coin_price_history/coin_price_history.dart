import 'package:json_annotation/json_annotation.dart';

part 'coin_price_history.g.dart';

@JsonSerializable()
class CoinPriceHistory {
  final String? price;
  final int? timestamp;

  const CoinPriceHistory({
    this.price,
    this.timestamp,
  });

  factory CoinPriceHistory.fromJson(Map<String, dynamic> json) => _$CoinPriceHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$CoinPriceHistoryToJson(this);
}
