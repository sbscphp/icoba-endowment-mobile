import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
// import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptUtils {
  static Future<Uint8List> capturePng({required GlobalKey key}) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Error capturing image: $e');
    }
  }

  //saves image(receipt) to gallery
  // static saveImageToGallery({
  //   required GlobalKey key,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     Uint8List bytes = await capturePng(key: key);
  //     final result = await ImageGallerySaverPlus.saveImage(bytes);
  //     if (result['isSuccess'] == true) {
  //       //show success message
  //       // showFlushBar(
  //       //   context: context,
  //       //   success: true,
  //       //   message: 'Receipt saved to your device',
  //       // );
  //     } else {
  //       //show error message
  //       // showFlushBar(context: context, message: defaultErrorMessage);
  //     }
  //   } catch (e) {
  //     //show error message
  //     // showFlushBar(context: context, message: e.toString());
  //   }
  // }

  //share image(receipt)
  static shareImage({
    required GlobalKey key,
    required BuildContext context,
  }) async {
    try {
      Uint8List bytes = await capturePng(key: key);
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/receipt.png').create();
      file.writeAsBytesSync(bytes);
      final xFile = XFile(file.path);
      SharePlus.instance.share(
        ShareParams(text: 'Here is your receipt', files: [xFile]),
      );
    } catch (e) {
      //show error message
      // showFlushBar(context: context, message: e.toString());
    }
  }

  // static Future<void> printReceipt({
  //   required BuildContext context,
  //   required ReceiptController? controller,
  //   required ValueChanged<bool> onDone,
  // }) async {
  //   try {
  //     //Let the user select a device
  //     final device = await FlutterBluetoothPrinter.selectDevice(context);

  //     if (device == null) {
  //       //Navigator.pop(context); // hide loading
  //       // showFlushBar(
  //       //   context: context,
  //       //   message: 'No printer selected',
  //       //   success: false,
  //       // );
  //       onDone(false);
  //       return;
  //     }

  //     //Send the print job and await completion
  //     await controller?.print(address: device.address);

  //     //Navigator.pop(context); // hide loading
  //     // showFlushBar(
  //     //   context: context,
  //     //   success: true,
  //     //   message: 'Receipt sent to printer',
  //     // );
  //     onDone(true);
  //   } catch (e) {
  //     // Navigator.pop(context); // hide loading
  //     // showFlushBar(
  //     //   context: context,
  //     //   message: 'Print error: $e',
  //     //   success: false,
  //     // );
  //     onDone(false);
  //   }
  // }
}
