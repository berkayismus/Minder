import 'package:flutter/material.dart';
import 'package:minder/brain/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MinderMain(),
          ),
        ),
      ),
    );
  }
}

class MinderMain extends StatefulWidget {
  @override
  _MinderMainState createState() => _MinderMainState();
}

class _MinderMainState extends State<MinderMain> {
  QuestionBrain _questionBrain = QuestionBrain();
  List<Icon> _scoreKeeper = [];

  int _correctCounter = 0;
  int _wrongCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _questionBrain.getQuestionText(),
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.pinkAccent,
              child: Text(
                'Doğru',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.cyan,
              child: Text(
                'Yanlış',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        ),
      ],
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      bool correctAnswer = _questionBrain.getQuestionAnswer();
      if (_questionBrain.isFinished() == true) {
        if (userPickedAnswer == correctAnswer) {
          _correctCounter++;
          _scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.greenAccent,
          ));
        } else {
          _wrongCounter++;
          _scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.redAccent,
          ));
        }
        showEndMessage();
        _questionBrain.resetQuestion();
      } else {
        if (userPickedAnswer == correctAnswer) {
          _correctCounter++;
          _scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.greenAccent,
          ));
        } else {
          _wrongCounter++;
          _scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.redAccent,
          ));
        }
        _questionBrain.nextQuestion();
      }
    });
  }

  void resetResultFields() {
    _scoreKeeper = [];
    _wrongCounter = 0;
    _correctCounter = 0;
  }

  void showEndMessage() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Tebrikler!",
      desc: "Doğru: $_correctCounter Yanlış: $_wrongCounter",
      buttons: [
        DialogButton(
          child: Text(
            "Yeniden başla",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
    resetResultFields();
  }
}
