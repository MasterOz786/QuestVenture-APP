import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/quiz_provider.dart';
import '../../../data/models/question_model.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../widgets/quiz/question_card.dart';
import '../../widgets/quiz/timer_widget.dart';
import '../../widgets/quiz/answer_option.dart';
import '../../navigation/app_router.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadQuiz();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, child) {
              if (quizProvider.isLoading && quizProvider.currentQuiz == null) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }

              if (quizProvider.currentQuestion == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.quiz,
                        size: 64.sp,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No questions available',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => quizProvider.loadQuiz(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    const QuestVentureLogo(),
                    SizedBox(height: 30.h),
                    _buildQuizCard(quizProvider.currentQuestion!),
                    SizedBox(height: 20.h),
                    _buildBottomSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(QuestionModel question) {
    return QuestionCard(
      child: Column(
        children: [
          Text(
            question.type == QuestionType.textInput
                ? 'TYPE CORRECT ANSWER'
                : 'SELECT THE CORRECT ANSWER',
            style: TextStyle(
              color: const Color(0xFF3498DB),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          _buildVideoThumbnail(question.videoThumbnail),
          SizedBox(height: 16.h),
          const TimerWidget(),
          SizedBox(height: 20.h),
          Text(
            question.questionNumber,
            style: TextStyle(
              color: const Color(0xFFE74C3C),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            question.question,
            style: TextStyle(
              color: const Color(0xFF3498DB),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _buildAnswerSection(question),
          SizedBox(height: 30.h),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail(String imageUrl) {
    return Container(
      width: double.infinity,
      height: 160.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 40.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Image not available',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        color: const Color(0xFF3498DB),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                width: 60.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(QuestionModel question) {
    switch (question.type) {
      case QuestionType.textBased:
        return _buildTextAnswers(question.answers);
      case QuestionType.textInput:
        return _buildTextInput();
      case QuestionType.imageBased:
        return _buildImageAnswers(question.answers, question.answerImages!);
    }
  }

  Widget _buildTextAnswers(List<String> answers) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return Column(
          children: List.generate(answers.length, (index) {
            return AnswerOption(
              text: answers[index],
              isSelected: quizProvider.getSelectedAnswer() == index,
              onTap: () => quizProvider.selectAnswer(index),
            );
          }),
        );
      },
    );
  }

  Widget _buildTextInput() {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return CustomTextField(
          controller: _textController,
          hintText: 'Type your answer here..',
          maxLines: 3,
          onChanged: (value) {
            quizProvider.selectAnswer(value.isNotEmpty ? value : null);
          },
        );
      },
    );
  }

  Widget _buildImageAnswers(List<String> answers, List<String> images) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AnswerOption(
                    text: answers[0],
                    imageUrl: images[0],
                    isSelected: quizProvider.getSelectedAnswer() == 0,
                    onTap: () => quizProvider.selectAnswer(0),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AnswerOption(
                    text: answers[1],
                    imageUrl: images[1],
                    isSelected: quizProvider.getSelectedAnswer() == 1,
                    onTap: () => quizProvider.selectAnswer(1),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AnswerOption(
                    text: answers[2],
                    imageUrl: images[2],
                    isSelected: quizProvider.getSelectedAnswer() == 2,
                    onTap: () => quizProvider.selectAnswer(2),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AnswerOption(
                    text: answers[3],
                    imageUrl: images[3],
                    isSelected: quizProvider.getSelectedAnswer() == 3,
                    onTap: () => quizProvider.selectAnswer(3),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNextButton() {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return CustomButton(
          text: 'NEXT',
          icon: Icons.arrow_forward,
          isLoading: quizProvider.isLoading,
          onPressed: quizProvider.getSelectedAnswer() != null ? _handleNext : null,
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return SizedBox(height: 20.h);
  }

  void _handleNext() async {
    final quizProvider = context.read<QuizProvider>();

    // Set the answer for text input questions
    if (quizProvider.currentQuestion?.type == QuestionType.textInput) {
      quizProvider.selectAnswer(_textController.text.trim());
    }

    // Submit the answer and check if it's correct
    final isCorrect = await quizProvider.submitAnswer();

    if (mounted) {
      if (quizProvider.isLastQuestion) {
        // Quiz completed - go directly to results
        print('Quiz completed with score: ${quizProvider.score}');
        Navigator.pushReplacementNamed(
          context,
          AppRouter.quizCompletion,
          arguments: quizProvider.score,
        );
      } else {
        // More questions - show ad then continue
        print('Going to ad screen, then next question');
        final result = await Navigator.pushNamed(context, AppRouter.ad);

        // After ad screen returns, continue to next question
        if (mounted) {
          print('Returned from ad screen, moving to next question');
          quizProvider.nextQuestion();
          _textController.clear();

          // Force rebuild to show next question
          setState(() {});
        }
      }
    }
  }
}
