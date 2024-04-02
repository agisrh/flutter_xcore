import 'dart:io';
import 'dart:typed_data';

class ImageData {
  ImageData({
    this.imgPath,
    this.imgSize,
    this.imgFile,
    this.imgBase64,
    this.imgUint8List,
  });
  String? imgPath;
  String? imgSize;
  File? imgFile;
  String? imgBase64;
  Uint8List? imgUint8List;
}
