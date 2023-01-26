/// Firebase Storage 인스턴스를 참조한 기능 구현

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  /// question_paper_images 경로 내의 .png 이미지 불러오기
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }

    try {
      var urlRef = firebaseStorage
          .child('question_paper_images')
          .child('${imgName.toLowerCase()}.png');

      var imgUrl = await urlRef.getDownloadURL();

      return imgUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getSplashLogoImage() async {
    try {
      var urlRef =
          firebaseStorage.child('basic_images').child('app_splash_logo.png');

      var imgUrl = await urlRef.getDownloadURL();

      return imgUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  UploadTask uploadXFile({
    required XFile xFile,
    required String fileName,
    required String extension,
  }) {
    File f = File(xFile.path);
    Reference ref =
        FirebaseStorage.instance.ref().child('profile_images').child(fileName);
    String ext;

    switch (extension) {
      case 'png':
        ext = 'png';
        break;
      case 'jpg':
        ext = 'jpeg';
        break;
      case 'jpeg':
        ext = 'jpeg';
        break;
      default:
        ext = 'jpeg';
        break;
    }

    final SettableMetadata metadata = SettableMetadata(
      contentType: 'image/$ext',
      customMetadata: {
        'picked-file-path': xFile.path,
      },
    );

    return ref.putFile(f, metadata);
  }
}
