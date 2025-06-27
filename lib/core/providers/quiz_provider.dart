import 'package:flutter/foundation.dart';
import '../../data/models/quiz_model.dart';
import '../../data/models/question_model.dart';
import '../services/api_service.dart';
import '../constants/app_constants.dart';

class QuizProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  QuizModel? _currentQuiz;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = false;
  String? _errorMessage;
  Map<int, dynamic> _answers = {};

  QuizModel? get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<int, dynamic> get answers => _answers;

  QuestionModel? get currentQuestion {
    if (_currentQuiz == null || _currentQuestionIndex >= _currentQuiz!.questions.length) {
      return null;
    }
    return _currentQuiz!.questions[_currentQuestionIndex];
  }

  bool get isLastQuestion {
    if (_currentQuiz == null) return true;
    return _currentQuestionIndex >= _currentQuiz!.questions.length - 1;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  Future<void> loadQuiz() async {
    print('Loading quiz...');
    _setLoading(true);
    _setError(null);

    try {
      _currentQuiz = await _apiService.getQuiz();
      _currentQuestionIndex = 0;
      _score = 0;
      _answers.clear();
      print('Quiz loaded successfully with ${_currentQuiz!.questions.length} questions');
    } catch (e) {
      print('Error loading quiz: $e');
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void selectAnswer(dynamic answer) {
    _answers[_currentQuestionIndex] = answer;
    print('Answer selected for question ${_currentQuestionIndex + 1}: $answer');
    notifyListeners();
  }

  dynamic getSelectedAnswer() {
    return _answers[_currentQuestionIndex];
  }

  Future<bool> submitAnswer() async {
    if (currentQuestion == null) {
      print('No current question to submit answer for');
      return false;
    }

    final selectedAnswer = getSelectedAnswer();
    if (selectedAnswer == null) {
      print('No answer selected');
      return false;
    }

    print('Submitting answer for question ${_currentQuestionIndex + 1}: $selectedAnswer');
    _setLoading(true);

    try {
      bool isCorrect = false;

      if (currentQuestion!.type == QuestionType.textInput) {
        isCorrect = selectedAnswer.toString().toLowerCase().trim() ==
            currentQuestion!.answers[currentQuestion!.correctAnswer].toLowerCase();
      } else {
        isCorrect = selectedAnswer == currentQuestion!.correctAnswer;
      }

      if (isCorrect) {
        _score += AppConstants.pointsPerCorrectAnswer;
        print('Correct answer! Score: $_score');
      } else {
        print('Incorrect answer. Score remains: $_score');
      }

      await Future.delayed(const Duration(seconds: 1));

      return isCorrect;
    } catch (e) {
      print('Error submitting answer: $e');
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      print('Moving to question ${_currentQuestionIndex + 1}/${_currentQuiz!.questions.length}');
      notifyListeners();
    } else {
      print('Already at last question');
    }
  }

  void resetQuiz() {
    print('Resetting quiz');
    _currentQuestionIndex = 0;
    _score = 0;
    _answers.clear();
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
