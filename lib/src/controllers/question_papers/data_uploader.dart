import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educational_app/src/firebase_ref/loading_status.dart';
import 'package:educational_app/src/firebase_ref/references.dart';
import 'package:educational_app/src/models/question_paper_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Json 데이터를 Firebase에 업로드
class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  /// loadingStatus는 obs
  final loadingStatus = LoadingStatus.loading.obs;

  // 컨트롤러에는 context 존재 X, 때문에 Get.context 사용
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; // 0

    /// Firebase 인스턴스 생성
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    /// Load json File And Print Path
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/DB/papers') && path.contains('.json'))
        .toList();

    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers.add(
        QuestionPaperModel.fromJson(
          json.decode(
            stringPaperContent,
          ),
        ),
      );
    }

    /// FireStore에 대한 CRUD 기능 동작
    var batch = fireStore.batch();

    for (var paper in questionPapers) {
      // Set Doc (ppr000)
      batch.set(
        questionPaperRef.doc(paper.id),
        {
          'title': paper.title,
          'image_url': paper.imageUrl,
          'description': paper.description,
          'time_seconds': paper.timeSeconds,
          'questions_count':
              paper.questions == null ? 0 : paper.questions!.length,
        },
      );

      for (var questions in paper.questions!) {
        final questionPath = questionRef(
          paperID: paper.id,
          questionID: questions.id,
        );
        // Set Doc (ppr000q000)
        batch.set(
          questionPath,
          {
            'question': questions.question,
            'correct_answer': questions.correctAnswer,
          },
        );

        for (var answers in questions.answers) {
          // Set Doc (A ~ D)
          batch.set(
            questionPath.collection('answers').doc(answers.identifier),
            {
              'identifier': answers.identifier,
              'answer': answers.answer,
            },
          );
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed; // 1
  }
}
