import 'package:minder/models/question.dart';

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(
        questionText:
            'Havaya atılan bir madeni paranın tura gelme ihtimali 1/2\'dir.',
        questionAnswer: true),
    Question(
        questionText: 'Q klavyede Q harfinin sağ yanında W harfi vardır.',
        questionAnswer: true),
    Question(questionText: '-2 çift sayıdır.', questionAnswer: true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  void resetQuestion() {
    _questionNumber = 0;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }
}
