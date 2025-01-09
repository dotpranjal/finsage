import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      text: 'What is compound interest?',
      options: [
        'Interest earned only on the principal amount',
        'Interest earned on both principal and accumulated interest',
        'A fixed interest rate that never changes',
        'Interest paid to compound investments'
      ],
      correctAnswer: 1,
    ),
    Question(
      text: 'Which investment typically carries the highest risk?',
      options: [
        'Government bonds',
        'Certificate of deposit',
        'Individual stocks',
        'Savings account'
      ],
      correctAnswer: 2,
    ),
    Question(
      text: 'What is diversification?',
      options: [
        'Investing all money in one promising stock',
        'Spreading investments across various assets',
        'Keeping all money in a savings account',
        'Taking high-risk investments only'
      ],
      correctAnswer: 1,
    ),
    // Add more questions as needed
  ];

  int currentQuestion = 0;
  int? selectedAnswer;
  bool hasSubmitted = false;
  int score = 0;

  void checkAnswer() {
    if (selectedAnswer == questions[currentQuestion].correctAnswer) {
      score++;
    }
    setState(() {
      hasSubmitted = true;
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        hasSubmitted = false;
      });
    } else {
      // Quiz completed
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Quiz Completed!'),
          content: Text('Your score: $score/${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestion = 0;
                  selectedAnswer = null;
                  hasSubmitted = false;
                  score = 0;
                });
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          title: Text('Quiz'),
          centerTitle: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Question ${currentQuestion + 1}/${questions.length}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (currentQuestion + 1) / questions.length,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        questions[currentQuestion].text,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 24),
                      ...List.generate(
                        questions[currentQuestion].options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: hasSubmitted
                                  ? index ==
                                          questions[currentQuestion].correctAnswer
                                      ? Colors.green.withOpacity(0.2)
                                      : selectedAnswer == index
                                          ? Colors.red.withOpacity(0.2)
                                          : null
                                  : selectedAnswer == index
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1)
                                      : null,
                              side: BorderSide(
                                color: hasSubmitted
                                    ? index ==
                                            questions[currentQuestion].correctAnswer
                                        ? Colors.green
                                        : selectedAnswer == index
                                            ? Colors.red
                                            : Theme.of(context).dividerColor
                                    : selectedAnswer == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).dividerColor,
                              ),
                            ),
                            onPressed: hasSubmitted
                                ? null
                                : () => setState(() => selectedAnswer = index),
                            child: Text(
                              questions[currentQuestion].options[index],
                              style: TextStyle(
                                color: hasSubmitted &&
                                        index ==
                                            questions[currentQuestion].correctAnswer
                                    ? Colors.green
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: selectedAnswer == null
                            ? null
                            : hasSubmitted
                                ? nextQuestion
                                : checkAnswer,
                        child: Text(
                          hasSubmitted ? 'Next Question' : 'Submit Answer',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}