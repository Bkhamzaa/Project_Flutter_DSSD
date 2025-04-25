import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/result_viewmodel.dart';
import 'package:provider/provider.dart';

import 'LeaderboardScreen.dart';

class ResultScreen extends StatefulWidget {
  final String playerName;
  final int score;

  const ResultScreen({
    Key? key,
    required this.playerName,
    required this.score,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ResultViewModel>().sendResult(widget.playerName, widget.score);

    });
  }

  @override
  Widget build(BuildContext context) {
    String titleMessage;
    IconData icon;
    Color iconColor;

    if (widget.score == 0) {
      titleMessage = 'Better luck next time, ${widget.playerName}!';
      icon = Icons.sentiment_dissatisfied;
      iconColor = Colors.redAccent;
    } else if (widget.score < 3) {
      titleMessage = 'Nice try, ${widget.playerName}!';
      icon = Icons.sentiment_neutral;
      iconColor = Colors.orangeAccent;
    } else {
      titleMessage = 'Congratulations, ${widget.playerName}!';
      icon = Icons.emoji_events;
      iconColor = Colors.amber;
    }

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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 100, color: iconColor),
                const SizedBox(height: 30),
                Text(
                  titleMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your score is:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.score}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // View Leaderboard Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the LeaderboardScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                    );
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
                  child: const Text('View Leaderboard'),
                ),
                const SizedBox(height: 20), // Add some spacing between buttons
                // Back to Home Button
                ElevatedButton(
                  onPressed: () {
                    // Reset quiz data and leaderboard, then navigate back to the home screen
                    context.read<ResultViewModel>().reset(context); // Reset quiz and leaderboard
                    Navigator.pop(context);  // Go back to the home screen
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
        ),
      ),
    );
  }
}
