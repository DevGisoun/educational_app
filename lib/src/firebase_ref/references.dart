import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// FireStore 인스턴스 생성
final fireStore = FirebaseFirestore.instance;

final userRef = fireStore.collection('users');
CollectionReference<Map<String, dynamic>> userMyRecentTestsRef({
  required String email,
}) =>
    userRef.doc(email).collection('myRecentTests');

final questionPaperRef = fireStore.collection('questionPapers');
DocumentReference questionRef({
  required String paperID,
  required String questionID,
}) =>
    questionPaperRef.doc(paperID).collection('questions').doc(questionID);

Reference get firebaseStorage => FirebaseStorage.instance.ref();
