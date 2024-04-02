import 'dart:io';
import 'app_core.dart';
import 'export_helper.dart';
import 'app_core_init.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class XCoreImp implements XCoreInit {
  static LocalDataSource get localData {
    if (!Get.isRegistered<LocalDataSource>()) {
      Get.lazyPut<LocalDataSource>(() => LocalDataSourceImp());
    }
    return Get.find();
  }

  static void Function()? onLoggedIn;

  @override
  String? hiveBox = "XCoreHiveBox";

  @override
  init({
    Environment environment = Environment.dev,
    bool temporaryMode = false,
    bool prototypeMode = false,
    bool demoMode = false,
  }) async {
    Env.environment = environment;
    XCore.isTemporary = temporaryMode;
    XCore.isProtoType = prototypeMode;
    XCore.isDemo = demoMode;

    if (!XCore.isTemporary) {
      Directory directory = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(directory.path);
      await HiveStorage.instance(hiveBox!);
    }
  }

  @override
  bool checkSession() {
    return localData.authToken != null;
  }

  @override
  logout() {
    localData.logout();
    GetInstance().resetInstance(
      clearRouteBindings: false,
    );
  }
}
