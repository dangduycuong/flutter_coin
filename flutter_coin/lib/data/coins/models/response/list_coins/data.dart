import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'coins.dart';
import 'stats.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final Stats? stats;
  final List<Coins>? coins;

  const Data({this.stats, this.coins});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => stats.hashCode ^ coins.hashCode;
}
