import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ohlc.dart';

part 'coin_ohlc_data.g.dart';

@JsonSerializable()
class CoinOHLCData {
  final List<OHLCItem>? ohlc;

  const CoinOHLCData({this.ohlc});

  factory CoinOHLCData.fromJson(Map<String, dynamic> json) =>
      _$CoinOHLCDataFromJson(json);

  Map<String, dynamic> toJson() => _$CoinOHLCDataToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinOHLCData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => ohlc.hashCode;
}
