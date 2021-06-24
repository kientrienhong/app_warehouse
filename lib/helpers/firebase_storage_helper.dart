import 'package:app_warehouse/api/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FirebaseStorageHelper {
  static Future<File> urlToFile(String imageUrl) async {
    var bytes = await rootBundle.load(imageUrl);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }

  static Future<String> uploadAvatar(
      File image, UploadTask task, String email) async {
    if (image == null) return '';

    final destination = '$email/avatar.png';

    task = FirebaseServices.uploadFile(destination, image);

    if (task == null) return '';

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  static Future<List<String>> uploadImage(
      String type, List<dynamic> image, UploadTask task, String email) async {
    int index = 0;

    return Future.wait(image.map((element) async {
      String destination = '$email/$type/${index.toString()}.png';
      task = FirebaseServices.uploadFile(destination, element);
      if (task == null) return null;
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      index++;
      return urlDownload;
    }));
  }
}
