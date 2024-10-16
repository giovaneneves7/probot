
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../config.dart';

class ImagePreviewController extends GetxController {
  dynamic image;
  bool isLoading = false;

  download(String url) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;

    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt <= 32) {
        status = await [Permission.storage].request();
      } else {
        status = await [Permission.photos].request();
      }
    } else {
      status = await [Permission.photosAddOnly].request();
    }

    var allAccept = true;
    status.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccept = false;
      }
    });

    if (allAccept) {
      isLoading = true;
      update();
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
   await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "probot");
      isLoading = false;
      update();
      Get.snackbar('Success', "Image Downloaded Successfully",
          backgroundColor: appCtrl.appTheme.icon,
          colorText: appCtrl.appTheme.sameWhite);
      update();
    } else {
      isLoading = false;
      update();
      Get.snackbar('Alert!', "Something Went Wrong",
          backgroundColor: appCtrl.appTheme.error,
          colorText: appCtrl.appTheme.sameWhite);
      update();
    }
  }

  @override
  void onReady() {

    var data = Get.arguments;
    image = data ?? "";
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
