import 'package:flutter/material.dart';
import 'package:quiz_app/quizzbrain.dart';

QuizzBrain quizzBrain = QuizzBrain();

class MyQuizzApp extends StatelessWidget {
  const MyQuizzApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "quizz app",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("QuiZz App"),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizzApp(),
          ),
        ),
      ),
    );
  }
}

class QuizzApp extends StatefulWidget {
  const QuizzApp({Key? key}) : super(key: key);

  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Icon> scorecounter = [];
  int viewScore = 0;

  void checkAnswer(bool userPickedAnswer) {
    int clearquestion = quizzBrain.questionBankLength();

    if (scorecounter.length == clearquestion) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Quizz Ends"),
            content: const Text("do you want to continue quizz?"),
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Your Score"),
                          content: Text("you scored\n $viewScore/8"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("ok"),
                            ),
                          ],
                        );
                      });
                },
                child: const Text("view score"),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      quizzBrain.resetFirstQuestion();
                      scorecounter.clear();
                      viewScore = 0;
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text("Ok")),
            ],
          );
        },
      );
    } else {
      bool correctAnswer = quizzBrain.getQuestionAnswer();
      setState(() {
        if (correctAnswer == userPickedAnswer) {
          viewScore++;
          scorecounter.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorecounter.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        quizzBrain.getNextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                "True",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                "False",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )),
        )),
        Row(
          children: scorecounter,
        ),
      ],
    );
  }
}
