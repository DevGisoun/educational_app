import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? github;
  String? name;
  String? profilepic;
  String? website;
  List<MyRecentTests>? myRecentTests;

  UserModel({
    this.email,
    this.github,
    this.name,
    this.profilepic,
    this.website,
    this.myRecentTests,
  });

  factory UserModel.fromJson(
      Map<String, dynamic> json, List<Map<String, dynamic>> list) {
    return UserModel(
      email: json['email'] as String,
      github: json['github'] as String,
      name: json['name'] as String,
      profilepic: json['profilepic'] as String,
      website: json['website'] as String,
      myRecentTests: list
          .map((dynamic e) => MyRecentTests.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : email = snapshot['email'],
        github = snapshot['github'],
        name = snapshot['name'],
        profilepic = snapshot['profilepic'],
        website = snapshot['website'];
  // myRecentTests = [];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'github': github,
      'name': name,
      'profilepic': profilepic,
      'website': website,
    };
  }
}

class MyRecentTests {
  String id;
  String correctAnswer;
  String points;
  String questionID;
  int time;

  MyRecentTests({
    required this.id,
    required this.correctAnswer,
    required this.points,
    required this.questionID,
    required this.time,
  });

  factory MyRecentTests.fromJson(Map<String, dynamic> json) {
    return MyRecentTests(
      id: json['question_id'] as String,
      correctAnswer: json['correct_answer'] as String,
      points: json['points'] as String,
      questionID: json['question_id'] as String,
      time: json['time'] as int,
    );
  }

  MyRecentTests.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'],
        correctAnswer = snapshot['correctAnswer'],
        points = snapshot['points'],
        questionID = snapshot['questionID'],
        time = snapshot['time'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'correctAnswer': correctAnswer,
      'points': points,
      'questionID': questionID,
      'time': time,
    };
  }
}
