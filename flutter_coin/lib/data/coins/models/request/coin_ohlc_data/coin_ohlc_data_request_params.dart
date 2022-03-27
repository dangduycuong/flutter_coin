import 'package:json_annotation/json_annotation.dart';

part 'coin_ohlc_data_request_params.g.dart';

@JsonSerializable()
class CoinOHLCDataRequestParams {
  final String referenceCurrencyUuid;
  final String timePeriod;

  CoinOHLCDataRequestParams({
    required this.referenceCurrencyUuid,
    required this.timePeriod,
  });

  factory CoinOHLCDataRequestParams.fromJson(Map<String, dynamic> json) =>
      _$CoinOHLCDataRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CoinOHLCDataRequestParamsToJson(this);
}
