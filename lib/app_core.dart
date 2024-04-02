import 'package:flutter/material.dart';
import 'app_core_init.dart';
import 'app_core_imp.dart';
import 'export_helper.dart';
export 'export_helper.dart';

extension XCore on XCoreInit {
  static ImageController get imageController {
    if (!Get.isRegistered<ImageController>()) {
      Get.lazyPut<ImageController>(() => ImageController());
    }
    return Get.find();
  }

  static bool isTemporary = false;
  static bool isProtoType = false;
  static bool isDemo = false;

  // ignore: prefer_function_declarations_over_variables
  static Function(String error) defaultErrorHandler = (error) {
    debugPrint(
        "If you see this message, it means default error handler is not setup");
  };

  static XCoreInit _instance() {
    if (!Get.isRegistered<XCoreInit>()) {
      Get.lazyPut<XCoreInit>(() => XCoreImp());
    }
    return Get.find<XCoreInit>();
  }

  static Future<void> init({
    Environment environment = Environment.dev,
    bool temporaryMode = false,
    bool prototypeMode = false,
    bool demoMode = false,
    void Function()? onLoggedIn,
  }) async {
    Get.smartManagement = SmartManagement.keepFactory;
    //masterData;
    XCoreImp.onLoggedIn = () {
      if (onLoggedIn != null) onLoggedIn();
    };
    await _instance().init(
      environment: environment,
      demoMode: demoMode,
      prototypeMode: prototypeMode,
      temporaryMode: temporaryMode,
    );
    if (checkSession() && XCoreImp.onLoggedIn != null) {
      XCoreImp.onLoggedIn!();
    }
  }

  static bool checkSession() {
    return _instance().checkSession();
  }

  static logout() {
    _instance().logout();
  }
}
