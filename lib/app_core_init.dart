import 'core/configs/environment.dart';

abstract class XCoreInit {
  init({
    Environment environment = Environment.dev,
    bool temporaryMode = false,
    bool prototypeMode = false,
    bool demoMode = false,
  });

  String? hiveBox;

  bool checkSession();

  logout();
}
