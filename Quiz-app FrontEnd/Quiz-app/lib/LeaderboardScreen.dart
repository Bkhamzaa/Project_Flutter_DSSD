import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/viewmodels/result_viewmodel.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<ResultViewModel>(
        builder: (context, resultViewModel, child) {
          final scores = resultViewModel.scores;
          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              return ListTile(
                title: Text(score['playerName']),
                subtitle: Text('Score: ${score['score']}'),
                trailing: Icon(Icons.star, color: Colors.amber),
              );
            },
          );
        },
      ),
    );
  }
}
