import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coin_ohlc_data.dart';

part 'coin_ohlc_data_response.g.dart';

@JsonSerializable()
class CoinOHLCDataResponse {
  final String? status;
  final CoinOHLCData? data;

  const CoinOHLCDataResponse({this.status, this.data});

  factory CoinOHLCDataResponse.fromJson(Map<String, dynamic> json) {
    return _$CoinOHLCDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoinOHLCDataResponseToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinOHLCDataResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
