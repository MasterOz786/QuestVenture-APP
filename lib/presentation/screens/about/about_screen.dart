import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../widgets/quiz/question_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                _buildAboutCard(),
                SizedBox(height: 20.h),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutCard() {
    return QuestionCard(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.buttonGradient,
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'ABOUT US',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: 280.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, color: Colors.white, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'QUEST VENTURE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppConstants.poweredBy,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10.sp,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'QUEST VENTURE',
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            AppConstants.companyDescription,
            style: TextStyle(
              color: AppColors.textBlue,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Text(
            'Powered By',
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Velitt',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'FIND AND FOLLOW US ON',
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                icon: Icons.camera_alt,
                color: AppColors.instagram,
                onTap: () => Helpers.launchURL(AppConstants.instagramUrl),
              ),
              SizedBox(width: 20.w),
              _buildSocialIcon(
                icon: Icons.facebook,
                color: AppColors.facebook,
                onTap: () => Helpers.launchURL(AppConstants.facebookUrl),
              ),
              SizedBox(width: 20.w),
              _buildSocialIcon(
                icon: Icons.chat,
                color: AppColors.whatsapp,
                onTap: () => Helpers.launchURL(AppConstants.whatsappUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.r),
        onTap: onTap,
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return SizedBox(height: 20.h);
  }
}
