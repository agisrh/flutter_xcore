import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_xcore/core/models/export_helper.dart';

class ImageController extends GetxController {
  // Original image variable
  var imgPath = ''.obs;
  var imgSize = ''.obs;
  var imgBase64 = ''.obs;
  File? imgFile;
  Uint8List? imgUint8List;

  void takeImage({
    bool imageCamera = true,
    var notifCancel,
    bool getBase64 = false,
    bool getUint8List = false,
    Function(ImageData)? result,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      // Pick Image
      imgPath.value = pickedFile.path;
      imgSize.value = imageSize(File(imgPath.value));
      imgFile = File(imgPath.value);

      if (getBase64) {
        final bytesPhoto = File(pickedFile.path).readAsBytesSync();
        imgBase64.value = base64Encode(bytesPhoto);
      }

      if (getUint8List) {
        imgUint8List = File(pickedFile.path).readAsBytesSync();
      }

      if (result != null) {
        result(
          ImageData(
            imgPath: imgPath.value,
            imgSize: imageSize(File(imgPath.value)),
            imgFile: File(imgPath.value),
            imgUint8List: imgUint8List,
            imgBase64: imgBase64.value,
          ),
        );
      }

      update();
    } else {
      notifCancel;
      //toastBottom(message: 'Tidak ada foto yang di ambil !');
    }
  }

  // Cancel image
  void cancel() {
    imgPath.value = '';
    imgPath.value = '';
    imgFile = null;
    update();
  }

  // Image size in Mb
  String imageSize(File file) {
    var size = "${((file).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    return size;
  }
}
