import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class CoinRequest {
  final String userName;
  final String password;

  CoinRequest({
    required this.userName,
    required this.password,
  });

  factory CoinRequest.fromJson(Map<String, dynamic> json) =>
      _$CoinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CoinRequestToJson(this);
}
