// lib/viewmodels/quiz_viewmodel.dart
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:myapp/models/question.dart';
import 'package:myapp/services/quiz_service.dart';

class QuizViewModel extends ChangeNotifier {
  final QuizService _quizService = QuizService();
  List<Question> _questions = [];
  List<Question> get questions => _questions;
  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;
  int _score = 0;
  int get score => _score;
  bool _answerChecked = false;
  bool get answerChecked => _answerChecked;
  int? _selectedAnswerIndex;
  int? get selectedAnswerIndex => _selectedAnswerIndex;

  // Fetch questions from the service
  Future<void> fetchQuestions() async {
    _questions = await _quizService.fetchQuestions();
    _questions.shuffle(Random()); // Shuffle to get random order
    notifyListeners();
  }
  // Reset all quiz-related state
  void resetQuiz() {
    _questions = []; // Clear the questions
    _currentQuestionIndex = 0; // Reset the current question index
    _score = 0; // Reset the score
    _answerChecked = false; // Reset answer checked flag
    _selectedAnswerIndex = null; // Reset the selected answer index
    notifyListeners(); // Notify listeners for state change
  }

  // Check the current answer
  void checkAnswer() {
    if (!_answerChecked) {
      _answerChecked = true;
      if (_selectedAnswerIndex == _questions[_currentQuestionIndex].answer) {
        _score++;
      }
      notifyListeners(); // Notify listeners after checking the answer
    }
  }

  // Move to the next question
  void goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _answerChecked = false;
      _selectedAnswerIndex = null;
      notifyListeners(); // Notify listeners when the question changes
    }
  }

  // Select an answer for the current question
  void selectAnswer(int index) {
    if (!_answerChecked) {
      _selectedAnswerIndex = index;
      notifyListeners(); // Notify listeners when an answer is selected
    }
  }

  // Check if it's the last question
  bool isLastQuestion() {
    return _currentQuestionIndex == _questions.length - 1;
  }
}
