import 'question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final List<QuestionModel> questions;
  final DateTime? createdAt;

  QuizModel({
    required this.id,
    required this.title,
    required this.questions,
    this.createdAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      questions: (json['questions'] as List<dynamic>?)
          ?.map((q) => QuestionModel.fromJson(q))
          .toList() ?? [],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  QuizModel copyWith({
    String? id,
    String? title,
    List<QuestionModel>? questions,
    DateTime? createdAt,
  }) {
    return QuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
