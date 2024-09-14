import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List? Qustions;
  int currentQustionCount = 0;
  int score = 0;
  final String difficultylevel;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultylevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    print("the provider work");
    _getQustionFromAPI();
  }
  Future<void> _getQustionFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultylevel,
      },
    );
    var data = jsonDecode(
      response.toString(),
    );
    Qustions = data["results"];
    notifyListeners();
    print(Qustions);
  }

  String getCurrentQuestionText() {
    if (Qustions != null && Qustions!.isNotEmpty) {
      return Qustions![currentQustionCount]['question'];
    } else {
      return "Loading...";
    }
  }

  void answerQustion(String answer) async {
    bool isCorrect = Qustions![currentQustionCount]['correct_answer'] == answer;
    if (isCorrect) score++;
    if (currentQustionCount < 10) {
      currentQustionCount++;
    }

    print(isCorrect ? "Correct" : "incorrect");
    // await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Icon(isCorrect ? Icons.check_circle : Icons.cancel_sharp),
    //         backgroundColor: isCorrect ? Colors.green : Colors.red,
    //       );
    //     });

    if (currentQustionCount > 9) {
      await EndGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> EndGame() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text("END GAME"),
          content: Text("Score $score /10"),
        );
      },
    );

    Navigator.pop(context);
  }
}
