import 'package:json_annotation/json_annotation.dart';

part 'ohlc.g.dart';

@JsonSerializable()
class OHLCItem {

  final int? startingAt;
  final int? endingAt;
  final String? open;
  final String? high;

  final String? low;
  final String? close;
  final String? avg;

  const OHLCItem({
    this.startingAt,
    this.endingAt,
    this.open,
    this.high,
    this.low,
    this.close,
    this.avg,
  });

  factory OHLCItem.fromJson(Map<String, dynamic> json) => _$OHLCItemFromJson(json);

  Map<String, dynamic> toJson() => _$OHLCItemToJson(this);
}
