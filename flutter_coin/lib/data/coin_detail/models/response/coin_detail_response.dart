import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coin_data_detail.dart';



part 'coin_detail_response.g.dart';

@JsonSerializable()
class CoinDetailResponseModel {
  final String? status;
  final CoinDataDetail? data;

  const CoinDetailResponseModel({this.status, this.data});

  factory CoinDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CoinDetailResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoinDetailResponseModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CoinDetailResponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
