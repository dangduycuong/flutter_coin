import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {
  final int? total;
  final int? totalCoins;
  final int? totalMarkets;
  final int? totalExchanges;
  final String? totalMarketCap;
  final String? total24hVolume;

  const Stats({
    this.total,
    this.totalCoins,
    this.totalMarkets,
    this.totalExchanges,
    this.totalMarketCap,
    this.total24hVolume,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Stats) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      total.hashCode ^
      totalCoins.hashCode ^
      totalMarkets.hashCode ^
      totalExchanges.hashCode ^
      totalMarketCap.hashCode ^
      total24hVolume.hashCode;
}
