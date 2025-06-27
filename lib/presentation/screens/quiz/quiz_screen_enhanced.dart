import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Enhanced Quiz Screen supporting both text and image-based questions
class QuizScreenEnhanced extends StatefulWidget {
  const QuizScreenEnhanced({super.key});

  @override
  State<QuizScreenEnhanced> createState() => _QuizScreenEnhancedState();
}

class _QuizScreenEnhancedState extends State<QuizScreenEnhanced> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  bool _isLoading = false;
  int _score = 0;

  final List<QuizQuestion> _questions = [
    QuizQuestion(
      questionNumber: "Q.1",
      question: "WHAT IS THE CAPITAL OF FRANCE?",
      videoThumbnail: "https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=800&h=400&fit=crop",
      answers: ["PARIS", "NEW YORK", "DUBLIN", "MANCHESTER"],
      correctAnswer: 0,
      questionType: QuestionType.textBased,
    ),
    QuizQuestion(
      questionNumber: "Q.2",
      question: "WHAT IS THE OLD NAME OF NEW YORK CITY?",
      videoThumbnail: "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800&h=400&fit=crop",
      answers: ["NEW AMSTERDAM", "NEW LONDON", "NEW PARIS", "NEW BERLIN"],
      correctAnswer: 0,
      questionType: QuestionType.textInput,
    ),
    QuizQuestion(
      questionNumber: "Q.3",
      question: "WHAT IS THE OLD NAME OF NEW YORK CITY?",
      videoThumbnail: "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=800&h=400&fit=crop",
      answers: ["NEW AMSTERDAM", "NEW LONDON", "NEW PARIS", "NEW BERLIN"],
      correctAnswer: 0,
      questionType: QuestionType.textInput,
    ),
    QuizQuestion(
      questionNumber: "Q.4",
      question: "WHAT IS THE CAPITAL OF FRANCE?",
      videoThumbnail: "https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=800&h=400&fit=crop",
      answers: ["PARIS", "NEW YORK", "DUBLIN", "MANCHESTER"],
      correctAnswer: 0,
      questionType: QuestionType.textBased,
    ),
    QuizQuestion(
      questionNumber: "Q.5",
      question: "WHAT IS THE CAPITAL OF FRANCE?",
      videoThumbnail: "https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=800&h=400&fit=crop",
      answers: ["PARIS", "NEW YORK", "BERLIN", "MUMBAI"],
      answerImages: [
        "https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=400&h=300&fit=crop", // Paris
        "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400&h=300&fit=crop", // New York
        "https://images.unsplash.com/photo-1587330979470-3016b6702d89?w=400&h=300&fit=crop", // Berlin
        "https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=400&h=300&fit=crop", // Mumbai
      ],
      correctAnswer: 0,
      questionType: QuestionType.imageBased,
    ),
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE74C3C), Color(0xFF3498DB)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                _buildTopLogo(),
                SizedBox(height: 30.h),
                _buildQuizCard(currentQuestion),
                SizedBox(height: 20.h),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopLogo() {
    return Container(
      width: 320.w,
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 27.5.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore, color: Colors.white, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'QUEST VENTURE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          Text(
            'POWERED BY VELITT',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 8.sp,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(QuizQuestion question) {
    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            question.questionType == QuestionType.textInput 
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
          _buildTimer(),
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
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

  Widget _buildTimer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3498DB),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, color: Colors.white, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            '10:00:28',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerSection(QuizQuestion question) {
    switch (question.questionType) {
      case QuestionType.textBased:
        return _buildTextAnswers(question.answers);
      case QuestionType.textInput:
        return _buildTextInput();
      case QuestionType.imageBased:
        return _buildImageAnswers(question.answers, question.answerImages!);
    }
  }

  Widget _buildTextAnswers(List<String> answers) {
    return Column(
      children: List.generate(answers.length, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.r),
              onTap: () {
                setState(() {
                  _selectedAnswer = index;
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: _selectedAnswer == index 
                      ? const Color(0xFF3498DB).withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: const Color(0xFF3498DB), width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3498DB).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: const Color(0xFF3498DB), width: 1),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        answers[index],
                        style: TextStyle(
                          color: const Color(0xFFE74C3C),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextInput() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: const Color(0xFF3498DB), width: 2),
      ),
      child: TextField(
        controller: _textController,
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Type your answer here..',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        ),
        maxLines: 3,
        onChanged: (value) {
          setState(() {
            _selectedAnswer = value.isNotEmpty ? 0 : null;
          });
        },
      ),
    );
  }

  Widget _buildImageAnswers(List<String> answers, List<String> images) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildImageAnswer(0, answers[0], images[0])),
            SizedBox(width: 12.w),
            Expanded(child: _buildImageAnswer(1, answers[1], images[1])),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildImageAnswer(2, answers[2], images[2])),
            SizedBox(width: 12.w),
            Expanded(child: _buildImageAnswer(3, answers[3], images[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildImageAnswer(int index, String text, String imageUrl) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.r),
        onTap: () {
          setState(() {
            _selectedAnswer = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectedAnswer == index 
                ? const Color(0xFF3498DB).withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xFF3498DB), width: 2),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.h,
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3498DB).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: const Color(0xFF3498DB), width: 1),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: const Color(0xFFE74C3C),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 80.h,
                margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE74C3C), Color(0xFFE67E22)],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE74C3C).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: _selectedAnswer != null && !_isLoading ? _handleNext : null,
          child: Center(
            child: _isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return SizedBox(height: 20.h);
  }

  void _handleNext() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final currentQuestion = _questions[_currentQuestionIndex];
    bool isCorrect = false;

    if (currentQuestion.questionType == QuestionType.textInput) {
      isCorrect = _textController.text.toLowerCase().trim() == 
                  currentQuestion.answers[currentQuestion.correctAnswer].toLowerCase();
    } else {
      isCorrect = _selectedAnswer == currentQuestion.correctAnswer;
    }

    if (isCorrect) {
      _score += 5; // 5 points per correct answer
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (_currentQuestionIndex < _questions.length - 1) {
        // Show ad screen before next question
        Navigator.pushNamed(context, '/ad').then((_) {
          setState(() {
            _currentQuestionIndex++;
            _selectedAnswer = null;
            _textController.clear();
          });
        });
      } else {
        // Quiz completed
        Navigator.pushReplacementNamed(context, '/results', arguments: _score);
      }
    }
  }
}

enum QuestionType { textBased, textInput, imageBased }

class QuizQuestion {
  final String questionNumber;
  final String question;
  final String videoThumbnail;
  final List<String> answers;
  final List<String>? answerImages;
  final int correctAnswer;
  final QuestionType questionType;

  QuizQuestion({
    required this.questionNumber,
    required this.question,
    required this.videoThumbnail,
    required this.answers,
    this.answerImages,
    required this.correctAnswer,
    required this.questionType,
  });
}
