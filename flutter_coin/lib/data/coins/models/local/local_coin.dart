import 'package:hive/hive.dart';

part 'local_coin.g.dart';

@HiveType(typeId: 0)
class LocalCoinModel {
  @HiveField(0)
  String? uuid;

  LocalCoinModel({
    this.uuid,
  });
}
