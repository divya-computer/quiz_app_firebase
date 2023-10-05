import 'package:flutter/material.dart';
import 'package:quiz_app_firebase/Constraints/Constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.questions,
      required this.indexAction,
      required this.totalQuestions});

  final String questions;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Questions ${indexAction + 1}/$totalQuestions:$questions',
        style: TextStyle(
          fontSize: 24,
          color: neutral,
        ),
      ),
    );
  }
}
