import 'package:json_annotation/json_annotation.dart';

part 'coins.g.dart';

@JsonSerializable()
class Coins {
  final String? uuid;
  final String? symbol;
  final String? name;
  final String? color;
  final String? iconUrl;
  final String? marketCap;
  final String? price;
  final int? listedAt;
  final int? tier;
  final String? change;
  final int? rank;
  final List<String>? sparkline;
  List<double>? doubleSparkline;
  final bool? lowVolume;
  @JsonKey(name: 'coinrankingUrl')
  final String? coinRankingUrl;

  @JsonKey(name: '24hVolume')
  final String? volume;
  final String? btcPrice;

  Coins({
    this.uuid,
    this.symbol,
    this.name,
    this.color,
    this.iconUrl,
    this.marketCap,
    this.price,
    this.listedAt,
    this.tier,
    this.change,
    this.rank,
    this.sparkline,
    this.doubleSparkline,
    this.lowVolume,
    this.coinRankingUrl,
    this.volume,
    this.btcPrice,
  });

  factory Coins.fromJson(Map<String, dynamic> json) => _$CoinsFromJson(json);

  Map<String, dynamic> toJson() => _$CoinsToJson(this);
}
