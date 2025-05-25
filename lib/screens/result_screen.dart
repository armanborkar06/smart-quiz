import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../data/models/quiz_data.dart';
import '../providers/quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: ${quizProvider.score}/${QuizData.getCategorizedQuestions()[quizProvider.selectedCategory]?.length ?? 0}',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'High Score: ${quizProvider.highScore}/${QuizData.getCategorizedQuestions()[quizProvider.selectedCategory]?.length ?? 0}',
              style: const TextStyle(fontSize: 20, color: Colors.yellowAccent),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                quizProvider.resetQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Restart Quiz', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Share.share(
                  'I scored ${quizProvider.score}/${QuizData.getCategorizedQuestions()[quizProvider.selectedCategory]?.length ?? 0} in the ${quizProvider.selectedCategory} quiz on Smart Quiz New!',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Share Score', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}