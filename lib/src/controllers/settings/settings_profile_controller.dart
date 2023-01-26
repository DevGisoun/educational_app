import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../firebase_ref/loading_status.dart';
import '../../models/user_model.dart';
import '../../services/firebase_storage_service.dart';
import '../auth_controller.dart';

class SettingsProfileController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;

  User? user = Get.find<AuthController>().getUser();

  RxString imageURL = ''.obs;
  RxString pageMessage = ''.obs;

  @override
  void onReady() {
    if (user == null) {
      pageMessage.value = '로그인';
      return;
    } else {
      pageMessage.value = '';
    }

    getProfileImageURL();

    super.onReady();
  }

  Future<void> getProfileImageURL() async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      await userRef.doc(user!.email).get().then((userModel) {
        imageURL.value = userModel['profilepic'];
        loadingStatus.value = LoadingStatus.completed;
      });
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? getUsersDoc() {
    if (user == null) {
      return null;
    }

    return userRef.doc(user!.email).get();
  }

  void navigateToLoginPage() {
    AuthController _authController = Get.find();
    Get.back();
    _authController.navigateToLoginPage();
  }

  Future<void> updateProfileImage({
    XFile? profilepic,
  }) async {
    if (user == null || profilepic == null) {
      return;
    }

    String extension = profilepic.path.split('.').last;
    if (extension != 'png' && extension != 'jpg' && extension != 'jpeg') {
      return;
    }

    String fileName = '${user!.email}/profile.$extension';

    UploadTask task = Get.find<FirebaseStorageService>().uploadXFile(
      xFile: profilepic,
      fileName: fileName,
      extension: extension,
    );

    task.snapshotEvents.listen((event) async {
      if (event.bytesTransferred == event.totalBytes &&
          event.state == TaskState.success) {
        String url = await event.ref.getDownloadURL();
        await userRef.doc(user!.email).update({
          'profilepic': url,
        });
      }
    });
    update();
  }
}
