import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../widgets/quiz/question_card.dart';
import '../../navigation/app_router.dart';

class QuizCompletionScreen extends StatelessWidget {
  final int score;

  const QuizCompletionScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                const QuestVentureLogo(),
                SizedBox(height: 30.h),
                _buildResultsCard(context),
                SizedBox(height: 20.h),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context) {
    return QuestionCard(
      child: Column(
        children: [
          Text(
            'QUEST COMPLETED',
            style: TextStyle(
              color: const Color(0xFF3498DB),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'SCORE: $score',
            style: TextStyle(
              color: const Color(0xFFE74C3C),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
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
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(ImageConstants.networkNewYork),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'ADDITIONAL INFORMATION',
            style: TextStyle(
              color: const Color(0xFF3498DB),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            AppConstants.additionalInfo,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.sp,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),
          CustomButton(
            text: 'NEXT',
            icon: Icons.arrow_forward,
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouter.about);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(ImageConstants.networkAdventure),
          fit: BoxFit.cover,
        ),
      ),
      child: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: VelittBranding(),
        ),
      ),
    );
  }
}
