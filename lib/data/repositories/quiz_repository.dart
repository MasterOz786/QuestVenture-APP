import '../models/quiz_model.dart';
import '../../core/services/api_service.dart';

class QuizRepository {
  final ApiService _apiService = ApiService();

  Future<QuizModel> getQuiz() async {
    try {
      return await _apiService.getQuiz();
    } catch (e) {
      throw Exception('Failed to load quiz: $e');
    }
  }

  Future<bool> submitAnswer(String questionId, dynamic answer) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      throw Exception('Failed to submit answer: $e');
    }
  }

  Future<Map<String, dynamic>> getLeaderboard() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return {
        'leaderboard': [],
        'user_rank': 1,
        'total_players': 100,
      };
    } catch (e) {
      throw Exception('Failed to load leaderboard: $e');
    }
  }
}
