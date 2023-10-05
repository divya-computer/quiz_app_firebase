import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_firebase/Constraints/Constants.dart';
import 'package:quiz_app_firebase/Widget/next_button.dart';
import 'package:quiz_app_firebase/Widget/option_card.dart';
import 'package:quiz_app_firebase/Widget/question_widget.dart';
import 'package:quiz_app_firebase/Widget/result_box.dart';
import 'package:quiz_app_firebase/model/db_connect.dart';
import 'package:quiz_app_firebase/model/questions_mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = DBconnect();

  late Future _questions;
  Future<List<Questions>> getData() async {
    return db.fetchQuestions();
  }

  // List<Questions> _questions = [
  //   Questions(
  //     id: '10',
  //     title: 'What is 2+2 ?',
  //     options: {'5': false, '30': false, '40': false, '4': true},
  //   ),
  //   Questions(
  //     id: '11',
  //     title: 'What is 5X7 ?',
  //     options: {'35': true, '30': false, '100': false, '14': false},
  //   ),
  // ];
  int index = 0;
  bool isPressed = false;
  int score = 0;
  bool isAlreadySelect = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          onPressed: startOver,
        ),
      );
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelect = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please Select Any Options'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
        );
      }
    }
  }

  void changeColor() {
    setState(() {
      isPressed = true;
    });
  }

  void checkAnswerandUpdate(bool value) {
    if (isAlreadySelect) {
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelect = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelect = false;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    _questions = getData();
    // insertToFirebase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Questions>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Questions>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: Text('Quiz App'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Score : $score',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      QuestionWidget(
                        questions: snapshot.data![index].title,
                        indexAction: index,
                        totalQuestions: snapshot.data!.length,
                      ),
                      Divider(color: neutral),
                      SizedBox(height: 25),
                      for (int i = 0;
                          i < snapshot.data![index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () => checkAnswerandUpdate(
                              snapshot.data![index].options.values.toList()[i]),
                          child: OptionCard(
                            option:
                                snapshot.data![index].options.keys.toList()[i],
                            color: isPressed
                                ? snapshot.data![index].options.values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(snapshot.data!.length),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Please Wait while Questions are loading..',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }

  void insertToFirebase() {
    // db.addQuestions(Questions(id: '11', title: 'What is 20 X 100', options: {
    //       '1000': false,
    //       '2000': true,
    //       '3000': false,
    //       '4000': false,
    //     }))
    //     .then((value) => print('Done Inserted'))
    //     .onError((error, stackTrace) => print('Some Error : $error'));

    db.fetchQuestions();
  }
}
