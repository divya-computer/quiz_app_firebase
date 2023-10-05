import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app_firebase/model/questions_mode.dart';

class DBconnect {
  final url = Uri.parse(
      'https://mcqs-flutter-ba6fa-default-rtdb.firebaseio.com/questions.json');

  Future<void> addQuestions(Questions questions) async {
    await http.post(url,
        body: json
            .encode({'title': questions.title, 'options': questions.options}));
  }

  Future<List<Questions>> fetchQuestions() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Questions> newQuestions = [];
      // data.forEach((key, value) {
      //   var newQuestion = Questions(
      //     id: key,
      //     title: value['title'],
      //     options: Map.castFrom(value['options']),
      //   );
      //   newQuestions.add(newQuestion);
      // });

      data.forEach((key, value) {
        var options;

        //need to understand this proper
        if (value['options'] is List<dynamic>) {
          List<dynamic> optionsList = value['options'];
          options = Map<String, bool>.fromIterable(optionsList,
              key: (item) => item.toString(), value: (_) => true);
        } else if (value['options'] is Map<dynamic, dynamic>) {
          options = Map<String, bool>.from(value['options']);
        }
        // till now ------------------

        var newQuestion = Questions(
          id: key,
          title: value['title'],
          options: options,
        );
        newQuestions.add(newQuestion);
      });

      print('Response : $newQuestions');

      return newQuestions;
    });
  }
}
