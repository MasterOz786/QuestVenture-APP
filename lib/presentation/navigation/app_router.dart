import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/location/location_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/ad/ad_screen.dart';
import '../screens/quiz/quiz_completion_screen.dart';
import '../screens/about/about_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String location = '/location';
  static const String quiz = '/quiz';
  static const String ad = '/ad';
  static const String quizCompletion = '/quiz-completion';
  static const String about = '/about';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case ad:
        return MaterialPageRoute(builder: (_) => const AdScreen());
      case quizCompletion:
        final score = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => QuizCompletionScreen(score: score),
        );
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
