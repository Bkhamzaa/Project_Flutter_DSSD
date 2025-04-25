import 'package:flutter/material.dart';
import 'package:myapp/player_name_screen.dart';  // Correct the import
import 'package:myapp/viewmodels/quiz_viewmodel.dart';
import 'package:provider/provider.dart';
import 'viewmodels/result_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizViewModel()),
        ChangeNotifierProvider(create: (_) => ResultViewModel()),
      ],
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlayerNameScreen(),
        debugShowCheckedModeBanner: false,  // Remove the debug banner
// Update this line to use PlayerNameScreen
      ),
    );
  }
}
