/// Firebase Storage 인스턴스를 참조한 기능 구현

import 'package:get/get.dart';

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
}
