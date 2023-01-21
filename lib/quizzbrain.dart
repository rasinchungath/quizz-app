import 'package:quiz_app/questions.dart';

class QuizzBrain {
  int _questionNumber = 0;
  final List<Question> _questionBank = [
    Question(
        q: '1.India is the seventh largest country in the world in the terms of total area',
        a: true),
    Question(q: '2.Tiger is known as the king of the forest', a: false),
    Question(q: '3.Sachin plays foot ball for india ', a: false),
    Question(
        q: '4.According to Indian wild life act indians can\'t keep native wild animals',
        a: true),
    Question(
        q: '5.New Delhi is the capital of india',
        a: true),
    Question(q: '6.Keyboard is an output device', a: false),
    Question(q: '7.Messi  plays foot ball for Brazil ', a: false),
    Question(
        q: '8.Fossil fuel is a non renewable source of energy',
        a: true),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].q;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].a;
  }

  int questionBankLength() {
    return _questionBank.length;
  }

  void getNextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void resetFirstQuestion() {
    _questionNumber = 0;
  }

  int getquestionNumber() {
    return _questionNumber;
  }
}
