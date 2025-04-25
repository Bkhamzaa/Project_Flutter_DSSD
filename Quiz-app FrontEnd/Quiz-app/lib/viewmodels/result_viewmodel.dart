import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:myapp/viewmodels/quiz_viewmodel.dart';
final String _baseUrl = 'http://192.168.0.82:8080/api';

class ResultViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> _scores = []; // Local list to store scores
  final url = Uri.parse('$_baseUrl/results');

  // Getter for scores
  List<Map<String, dynamic>> get scores => _scores;

  // Method to send the result to the server
  Future<void> sendResult(String playerName, int score) async {
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'joueur': playerName,
          'score': score,
          'date': DateTime.now().toIso8601String(), // e.g. "2025-04-25T14:30:00Z"
        }),
      );

      if (response.statusCode == 200) {
        print("Result stored correctly");

        // After sending, fetch the updated leaderboard
        await fetchLeaderboard();
      } else {
        print('Failed to send result');
      }
    } catch (e) {
      print('Error sending result: $e');
    }
  }

  // Method to fetch the leaderboard from the server
  Future<void> fetchLeaderboard() async {
    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        // Parse the response and update the local scores list
        List<dynamic> data = jsonDecode(response.body);
        _scores = data.map((score) => {
          'playerName': score['joueur'],
          'score': score['score'],
        }).toList();
        notifyListeners(); // Notify listeners to update the UI
      } else {
        print('Failed to fetch leaderboard');
      }
    } catch (e) {
      print('Error fetching leaderboard: $e');
    }
  }

  // Method to reset the scores
  void reset(BuildContext context) {
    // Reset the quiz data using QuizViewModel's resetQuiz method
    context.read<QuizViewModel>().resetQuiz();

    // Optionally reset the leaderboard as well (clear scores)
    _scores = [];
    notifyListeners();
  }



}
