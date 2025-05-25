import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/models/question.dart';
import '../data/models/quiz_data.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  String _selectedCategory = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _highScore = 0;
  bool _isQuizCompleted = false;
  int _secondsRemaining = 30;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get score => _score;
  int get highScore => _highScore;
  bool get isQuizCompleted => _isQuizCompleted;
  int get secondsRemaining => _secondsRemaining;
  String get selectedCategory => _selectedCategory;

  QuizProvider() {
    _loadHighScore();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _questions = QuizData.getCategorizedQuestions()[category] ?? [];
    _startTimer();
    notifyListeners();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    notifyListeners();
  }

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (_score > _highScore) {
      _highScore = _score;
      await prefs.setInt('highScore', _highScore);
      notifyListeners();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _moveToNextQuestion();
      }
    });
  }

  void answerQuestion(int selectedIndex) async {
    if (selectedIndex == currentQuestion.correctAnswerIndex) {
      _score++;
      await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
    } else {
      await _audioPlayer.play(AssetSource('sounds/incorrect.mp3'));
    }
    await _saveHighScore();
    _moveToNextQuestion();
  }

  void skipQuestion() {
    _moveToNextQuestion();
  }

  void _moveToNextQuestion() {
    _timer?.cancel();
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= _questions.length) {
      _isQuizCompleted = true;
    } else {
      _startTimer();
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizCompleted = false;
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}