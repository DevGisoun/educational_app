import 'package:educational_app/src/widgets/common/background_decoration.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  static const String routeName = '/questionsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
        child: Center(
          child: Text('하이 ㅋㅋ'),
        ),
      ),
    );
  }
}
