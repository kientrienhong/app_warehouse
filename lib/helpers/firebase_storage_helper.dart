import '/api/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as FirebaseStorage;
import 'package:firebase_core/firebase_core.dart';
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

  static Future<List<String>> listExample(
      String email, int idStorage, String type) async {
    FirebaseStorage.ListResult result = await FirebaseStorage
        .FirebaseStorage.instance
        .ref()
        .child(email)
        .child(idStorage.toString())
        .child(type)
        .listAll();
    List<String> listFile = [];
    result.items.forEach((FirebaseStorage.Reference ref) {
      listFile.add(ref.name);
    });

    // result.prefixes.forEach((FirebaseStorage.Reference ref) {
    //   print('Found directory: ${ref.name}');
    // });
    return listFile;
  }

  static Future<String> uploadAvatar(
      File image, FirebaseStorage.UploadTask task, String email) async {
    if (image == null) return '';

    final destination = '$email/avatar.png';

    task = FirebaseServices.uploadFile(destination, image);

    if (task == null) return '';

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  static Future<List<Map<String, dynamic>>> uploadImage(
      String type,
      List<dynamic> image,
      FirebaseStorage.UploadTask task,
      String email,
      int storageId) async {
    print('image');
    print(image);
    int index = 0;
    int typeInt = type == 'imageStorage' ? 0 : 1;
    List<String> existedFile = await listExample(email, storageId, type);
    int exceed = existedFile.length - image.length;
    if (exceed > 0) {
      for (int i = existedFile.length - exceed; i < existedFile.length; i++) {
        final firebaseStorageRef = FirebaseStorage.FirebaseStorage.instance
            .ref()
            .child(email)
            .child(storageId.toString())
            .child(type)
            .child('${i.toString()}.png');
        await firebaseStorageRef.delete();
      }
    }
    return Future.wait(image.map((element) async {
      if (element['file'] != null) {
        String destination =
            '$email/${storageId.toString()}/$type/${index.toString()}.png';

        index++;
        task = FirebaseServices.uploadFile(destination, element['file']);
        if (task == null) return null;
        final snapshot = await task.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        return {'imageUrl': urlDownload, 'id': element['id'], 'type': typeInt};
      }
      index++;

      return element;
    }));
  }
}
