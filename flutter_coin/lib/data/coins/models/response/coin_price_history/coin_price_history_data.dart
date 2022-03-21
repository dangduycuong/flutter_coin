import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coin_price_history.dart';

part 'coin_price_history_data.g.dart';

@JsonSerializable()
class CoinPriceHistoryData {
  final String? change;
  final List<CoinPriceHistory>? history;

  const CoinPriceHistoryData({this.change, this.history});

  factory CoinPriceHistoryData.fromJson(Map<String, dynamic> json) =>
      _$CoinPriceHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CoinPriceHistoryDataToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinPriceHistoryData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => change.hashCode ^ history.hashCode;
}
