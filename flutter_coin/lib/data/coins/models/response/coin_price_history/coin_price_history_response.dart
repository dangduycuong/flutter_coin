import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coin_price_history_data.dart';

part 'coin_price_history_response.g.dart';

@JsonSerializable()
class CoinPriceHistoryResponse {
  final String? status;
  final CoinPriceHistoryData? data;

  const CoinPriceHistoryResponse({this.status, this.data});

  factory CoinPriceHistoryResponse.fromJson(Map<String, dynamic> json) {
    return _$CoinPriceHistoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoinPriceHistoryResponseToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinPriceHistoryResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
