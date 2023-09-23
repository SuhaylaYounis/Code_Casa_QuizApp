import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'Paris', 'correct': true},
        {'text': 'Berlin', 'correct': false},
        {'text': 'Madrid', 'correct': false},
        {'text': 'London', 'correct': false},
      ],
    },
    {
      'questionText': 'Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'correct': false},
        {'text': 'Adobe', 'correct': false},
        {'text': 'Google', 'correct': true},
        {'text': 'Microsoft', 'correct': false},
      ],
    },
    {
      'questionText': 'What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'correct': false},
        {'text': 'IOS Development Kit', 'correct': false},
        {'text': 'Web Development Kit', 'correct': false},
        {
          'text':
          'SDK to build IOS, Android, Web & Desktop Native Apps',
          'correct': true
        },
      ],
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': [
        {'text': 'Earth', 'correct': false},
        {'text': 'Mars', 'correct': true},
        {'text': 'Venus', 'correct': false},
        {'text': 'Jupiter', 'correct': false},
      ],
    },
    {
      'questionText': 'Which programming language is used by Flutter?',
      'answers': [
        {'text': 'Ruby', 'correct': false},
        {'text': 'Dart', 'correct': true},
        {'text': 'C++', 'correct': false},
        {'text': 'Kotlin', 'correct': false},
      ],
    },
    {
      'questionText': 'What is 2 + 2?',
      'answers': [
        {'text': '3', 'correct': false},
        {'text': '4', 'correct': true},
        {'text': '5', 'correct': false},
        {'text': '6', 'correct': false},
      ],
    },
  ];

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _score++;
      }
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(
          child: Text(
            'Quiz App',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _questions.length, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function(bool) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'].toString()),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(

            answer['text'].toString(),
            () => answerQuestion(answer['correct'] as bool),
          );
        }).toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35, bottom: 35),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 35),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final Function selectHandler;

  Answer(this.answerText, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),

      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style:ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              primary: Colors.teal
            ) ,
            onPressed: () => selectHandler(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(answerText,style: TextStyle(fontSize: 30),)),
            ),
          ),
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function resetHandler;

  Result(this.score, this.totalQuestions, this.resetHandler);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Great Job!\n'
            'You scored $score out of $totalQuestions!',
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55.0),
            child: ElevatedButton(
              onPressed: () => resetHandler(),
              style:ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  primary: Colors.teal
              ) ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Restart Quiz',style: TextStyle(fontSize: 30),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
