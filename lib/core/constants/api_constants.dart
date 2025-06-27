class ApiConstants {
  static const String baseUrl = 'https://api.questventure.com';
  static const String authBaseUrl = '$baseUrl/auth';
  static const String quizBaseUrl = '$baseUrl/quiz';
  static const String locationBaseUrl = '$baseUrl/location';
  
  static const String loginEndpoint = '/login';
  static const String verifyOtpEndpoint = '/verify-otp';
  static const String questionsEndpoint = '/questions';
  static const String submitAnswerEndpoint = '/submit-answer';
  static const String leaderboardEndpoint = '/leaderboard';
  
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}
