import 'package:cloud_firestore/cloud_firestore.dart';

/// FireStore 인스턴스 생성
final fireStore = FirebaseFirestore.instance;

final questionPaperRef = fireStore.collection('questionPapers');
DocumentReference questionRef({
  required String paperID,
  required String questionID,
}) =>
    questionPaperRef.doc(paperID).collection('questions').doc(questionID);
