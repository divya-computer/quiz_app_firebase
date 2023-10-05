import 'package:flutter/material.dart';
import 'package:quiz_app_firebase/Constraints/Constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Next Question',
        textAlign: TextAlign.center,
      ),
    );
  }
}
