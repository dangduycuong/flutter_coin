import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'list_coins_response.g.dart';

@JsonSerializable()
class ListCoinsResponse {
  final String? status;
  final Data? data;

  const ListCoinsResponse({this.status, this.data});

  factory ListCoinsResponse.fromJson(Map<String, dynamic> json) {
    return _$ListCoinsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListCoinsResponseToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ListCoinsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
