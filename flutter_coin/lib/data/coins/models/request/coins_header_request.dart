import 'package:json_annotation/json_annotation.dart';

part 'coins_header_request.g.dart';

@JsonSerializable()
class CoinsHeaderRequest {
  final String host;
  final String key;

  CoinsHeaderRequest({
    required this.host,
    required this.key,
  });

  factory CoinsHeaderRequest.fromJson(Map<String, dynamic> json) =>
      _$CoinsHeaderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CoinsHeaderRequestToJson(this);
}