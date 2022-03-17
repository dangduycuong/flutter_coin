import 'package:hive/hive.dart';

part 'local_coin.g.dart';

@HiveType(typeId: 0)
class LocalCoinModel {
  @HiveField(0)
  String? uuid;

  @HiveField(1)
  String? iconUrl;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? symbol;

  @HiveField(4)
  String? price;

  @HiveField(5)
  List<String>? sparkline;

  @HiveField(6)
  String? color;

  @HiveField(7)
  String? change;

  LocalCoinModel({
    this.uuid,
    this.iconUrl,
    this.name,
    this.symbol,
    this.price,
    this.sparkline,
    this.color,
    this.change,
  });
}
