import 'package:flutter_xcore/developer_logs.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static Box? boxData;
  static Future<Box> instance(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      boxData = Hive.box(boxName);
      logData("[HiveStorage][Box] box $boxName opened");
      return boxData!;
    } else {
      boxData = await Hive.openBox(boxName);
      logData("[HiveStorage][OpenBox] box $boxName created");
      return boxData!;
    }
  }

  static Future<void> put({required String key, required dynamic value}) async {
    var put = await boxData?.put(key, value);
    logData(
        "[HiveStorage][Put] box ${boxData?.name} creating key $key with value $value");
    return put;
  }

  static dynamic get({required String key}) {
    var value = boxData?.get(key);
    logData(
        "[HiveStorage][Get] box ${boxData?.name}, key $key with value $value");
    return value;
  }
}
