import 'package:json_annotation/json_annotation.dart';

part 'list_coins_params_request.g.dart';

@JsonSerializable()
class ListCoinsParamsRequest {
  final String referenceCurrencyUuid;
  final String timePeriod;
  final String tiers;
  final String orderBy;

  final String? search;
  final String orderDirection;
  final int limit;
  final int offset;

  ListCoinsParamsRequest({
    required this.referenceCurrencyUuid,
    required this.timePeriod,
    required this.tiers,
    required this.orderBy,
    required this.search,
    required this.orderDirection,
    required this.limit,
    required this.offset,
  });

  factory ListCoinsParamsRequest.fromJson(Map<String, dynamic> json) =>
      _$ListCoinsParamsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListCoinsParamsRequestToJson(this);
}