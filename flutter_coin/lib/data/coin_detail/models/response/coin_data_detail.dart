import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'coin_detail_item.dart';

part 'coin_data_detail.g.dart';

@JsonSerializable()
class CoinDataDetail {
  final CoinDetailItem? coin;

  const CoinDataDetail({this.coin});

  factory CoinDataDetail.fromJson(Map<String, dynamic> json) => _$CoinDataDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDataDetailToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinDataDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => coin.hashCode;
}
