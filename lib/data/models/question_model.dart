enum QuestionType { textBased, textInput, imageBased }

class QuestionModel {
  final String id;
  final String questionNumber;
  final String question;
  final String videoThumbnail;
  final List<String> answers;
  final List<String>? answerImages;
  final int correctAnswer;
  final QuestionType type;

  QuestionModel({
    required this.id,
    required this.questionNumber,
    required this.question,
    required this.videoThumbnail,
    required this.answers,
    this.answerImages,
    required this.correctAnswer,
    required this.type,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      questionNumber: json['question_number'] ?? '',
      question: json['question'] ?? '',
      videoThumbnail: json['video_thumbnail'] ?? '',
      answers: List<String>.from(json['answers'] ?? []),
      answerImages: json['answer_images'] != null 
          ? List<String>.from(json['answer_images'])
          : null,
      correctAnswer: json['correct_answer'] ?? 0,
      type: _parseQuestionType(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_number': questionNumber,
      'question': question,
      'video_thumbnail': videoThumbnail,
      'answers': answers,
      'answer_images': answerImages,
      'correct_answer': correctAnswer,
      'type': type.toString().split('.').last,
    };
  }

  static QuestionType _parseQuestionType(String? typeString) {
    switch (typeString) {
      case 'textBased':
        return QuestionType.textBased;
      case 'textInput':
        return QuestionType.textInput;
      case 'imageBased':
        return QuestionType.imageBased;
      default:
        return QuestionType.textBased;
    }
  }

  QuestionModel copyWith({
    String? id,
    String? questionNumber,
    String? question,
    String? videoThumbnail,
    List<String>? answers,
    List<String>? answerImages,
    int? correctAnswer,
    QuestionType? type,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      questionNumber: questionNumber ?? this.questionNumber,
      question: question ?? this.question,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      answers: answers ?? this.answers,
      answerImages: answerImages ?? this.answerImages,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      type: type ?? this.type,
    );
  }
}
