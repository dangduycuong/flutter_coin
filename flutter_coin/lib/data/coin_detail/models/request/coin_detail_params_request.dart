import 'package:json_annotation/json_annotation.dart';

part 'coin_detail_params_request.g.dart';

@JsonSerializable()
class CoinDetailParamsRequest {
  final String referenceCurrencyUuid;
  final String timePeriod;

  CoinDetailParamsRequest({
    required this.referenceCurrencyUuid,
    required this.timePeriod,
  });

  factory CoinDetailParamsRequest.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailParamsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDetailParamsRequestToJson(this);
}