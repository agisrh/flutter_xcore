import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompress {
  static Future<Uint8List> toMaxSize(Uint8List image, int maxSize) async {
    int compareLength = image.lengthInBytes;

    int quality = 100;

    Uint8List result = image;

    bool canLoop = true;

    while (canLoop) {
      //change quality decrease to 1 when quality below 11
      if (quality <= 10) {
        quality--;
      } else {
        quality = quality - 10;
      }

      if (quality < 0) {
        quality = 0;
        canLoop = false;
      }
      result = (await FlutterImageCompress.compressWithList(
        image,
        quality: quality,
      ));
      compareLength = result.lengthInBytes;

      //check length
      if (compareLength <= maxSize) {
        canLoop = false;
      }
    }

    // debugPrint("original file size : ${image.lengthInBytes}");
    // debugPrint("compressed file size : ${result.lengthInBytes}");
    return result;
  }
}
