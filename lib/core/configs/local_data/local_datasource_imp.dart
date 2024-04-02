import 'package:flutter_xcore/app_core.dart';
import 'package:flutter_xcore/app_core_imp.dart';

class LocalDataSourceImp implements LocalDataSource {
  @override
  void logout() {
    if (XCore.isTemporary) {
      authToken = null;
    } else {
      HiveStorage.boxData!.clear();
    }
  }

  String? _authToken;
  @override
  String? get authToken =>
      XCore.isTemporary ? _authToken : HiveStorage.get(key: "authToken");
  @override
  set authToken(String? token) {
    XCore.isTemporary
        ? _authToken = token
        : HiveStorage.put(key: "authToken", value: token).then((value) {
            if (XCoreImp.onLoggedIn != null) {
              XCoreImp.onLoggedIn!();
            }
          });
  }

  // List<PartnerData> _partnerData = [];
  // @override
  // List<PartnerData> get partnerData {
  //   if (QTCore.isTemporary) {
  //     return _partnerData;
  //   }
  //   if (HiveStorage.get(key: "partnerData") != null) {
  //     List<String> listData = HiveStorage.get(key: "partnerData");
  //     return listData.map((e) => PartnerData.fromJson(jsonDecode(e))).toList();
  //   }
  //   return [];
  // }

  // @override
  // set partnerData(List<PartnerData> value) {
  //   if (QTCore.isTemporary) {
  //     _partnerData = value;
  //     return;
  //   }
  //   List<String> listString =
  //       value.map((data) => jsonEncode(data.toJson())).toList();
  //   HiveStorage.put(key: "partnerData", value: listString);
  // }
}
