import 'package:json_annotation/json_annotation.dart';

part 'coin_price_history_request_params.g.dart';

@JsonSerializable()
class CoinPriceHistoryRequestParams {
  final String referenceCurrencyUuid;
  final String timePeriod;

  CoinPriceHistoryRequestParams({
    required this.referenceCurrencyUuid,
    required this.timePeriod,
  });

  factory CoinPriceHistoryRequestParams.fromJson(Map<String, dynamic> json) =>
      _$CoinPriceHistoryRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CoinPriceHistoryRequestParamsToJson(this);
}
