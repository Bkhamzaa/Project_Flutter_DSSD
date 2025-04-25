import 'package:flutter/material.dart';
import 'package:myapp/result_screen.dart';
import 'package:myapp/models/question.dart';
import 'package:myapp/viewmodels/quiz_viewmodel.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;

  const QuizScreen({Key? key, required this.playerName}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuizViewModel>().fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final quizViewModel = context.watch<QuizViewModel>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: quizViewModel.questions.isEmpty
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Consumer<QuizViewModel>(
          builder: (context, viewModel, child) {
            final question = viewModel.questions[viewModel.currentQuestionIndex];

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      question.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ...question.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      Color tileColor;

                      if (viewModel.selectedAnswerIndex == index) {
                        if (viewModel.answerChecked) {
                          tileColor = index == question.answer
                              ? Colors.green
                              : Colors.red;
                        } else {
                          tileColor = Colors.white70;
                        }
                      } else {
                        tileColor = Colors.white;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => viewModel.selectAnswer(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tileColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(option, style: const TextStyle(fontSize: 16)),
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (!viewModel.answerChecked) {
                          viewModel.checkAnswer();
                        } else {
                          if (viewModel.isLastQuestion()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  playerName: widget.playerName,
                                  score: viewModel.score,
                                ),
                              ),
                            );
                          } else {
                            viewModel.goToNextQuestion();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        viewModel.answerChecked
                            ? (viewModel.isLastQuestion() ? 'See Result' : 'Next')
                            : 'Check',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Reset the quiz state before navigating back to home
                        viewModel.resetQuiz();
                        Navigator.pop(context); // Go back to home screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
