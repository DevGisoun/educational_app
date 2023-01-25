import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:educational_app/src/models/user_model.dart';

class UserRepository {
  static Future<UserModel?> loginCheckByEmail(
      String email, List<Map<String, dynamic>> list) async {
    QuerySnapshot<Map<String, dynamic>> data =
        await userRef.where('email', isEqualTo: email).get();

    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs.first.data(), list);
    }
  }
}
