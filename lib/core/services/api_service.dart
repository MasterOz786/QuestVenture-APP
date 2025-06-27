import 'dart:convert';
import '../../data/models/quiz_model.dart';
import '../../data/models/question_model.dart';
import '../constants/image_constants.dart';

class ApiService {
  Future<QuizModel> getQuiz() async {
    await Future.delayed(const Duration(seconds: 1));
    return _getMockQuiz();
  }

  QuizModel _getMockQuiz() {
    return QuizModel(
      id: '1',
      title: 'Geography Quiz',
      questions: [
        QuestionModel(
          id: '1',
          questionNumber: 'Q.1',
          question: 'WHAT IS THE CAPITAL OF FRANCE?',
          videoThumbnail: ImageConstants.networkEiffelTower,
          answers: ['PARIS', 'NEW YORK', 'DUBLIN', 'MANCHESTER'],
          correctAnswer: 0,
          type: QuestionType.textBased,
        ),
        QuestionModel(
          id: '2',
          questionNumber: 'Q.2',
          question: 'WHAT IS THE OLD NAME OF NEW YORK CITY?',
          videoThumbnail: ImageConstants.networkNewYork,
          answers: ['NEW AMSTERDAM', 'NEW LONDON', 'NEW PARIS', 'NEW BERLIN'],
          correctAnswer: 0,
          type: QuestionType.textInput,
        ),
        QuestionModel(
          id: '3',
          questionNumber: 'Q.3',
          question: 'WHAT IS THE OLD NAME OF NEW YORK CITY?',
          videoThumbnail: ImageConstants.networkNewYork,
          answers: ['NEW AMSTERDAM', 'NEW LONDON', 'NEW PARIS', 'NEW BERLIN'],
          correctAnswer: 0,
          type: QuestionType.textInput,
        ),
        QuestionModel(
          id: '4',
          questionNumber: 'Q.4',
          question: 'WHAT IS THE CAPITAL OF FRANCE?',
          videoThumbnail: ImageConstants.networkEiffelTower,
          answers: ['PARIS', 'NEW YORK', 'DUBLIN', 'MANCHESTER'],
          correctAnswer: 0,
          type: QuestionType.textBased,
        ),
        QuestionModel(
          id: '5',
          questionNumber: 'Q.5',
          question: 'WHAT IS THE CAPITAL OF FRANCE?',
          videoThumbnail: ImageConstants.networkEiffelTower,
          answers: ['PARIS', 'NEW YORK', 'BERLIN', 'MUMBAI'],
          answerImages: [
            ImageConstants.networkEiffelTower,
            ImageConstants.networkNewYork,
            ImageConstants.networkBerlin,
            ImageConstants.networkMumbai,
          ],
          correctAnswer: 0,
          type: QuestionType.imageBased,
        ),
      ],
    );
  }
}
