import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/coin_detail/entities/coin_detail_entity.dart';

part 'coin_detail_item.g.dart';

@JsonSerializable()
class CoinDetailItem {
  final String? uuid;
  final String? symbol;
  final String? name;
  final String? description;

  final String? color;
  final String? iconUrl;
  final String? websiteUrl;
  final int? numberOfMarkets;

  final int? numberOfExchanges;
  @JsonKey(name: '24hVolume')
  final String? volume;
  final String? marketCap;
  final String? price;

  final String? btcPrice;
  final int? priceAt;
  final String? change;
  final int? rank;

  final List<String>? sparkline;
  @JsonKey(name: 'coinrankingUrl')
  final String? coinRankingUrl;
  final int? tier;
  final bool? lowVolume;

  final int? listedAt;

  const CoinDetailItem({
    this.uuid,
    this.symbol,
    this.name,
    this.description,
    this.color,
    this.iconUrl,
    this.websiteUrl,
    this.numberOfMarkets,
    this.numberOfExchanges,
    this.volume,
    this.marketCap,
    this.price,
    this.btcPrice,
    this.priceAt,
    this.change,
    this.rank,
    this.sparkline,
    this.coinRankingUrl,
    this.tier,
    this.lowVolume,
    this.listedAt,
  });

  factory CoinDetailItem.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDetailItemToJson(this);
}
