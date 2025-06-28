import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gradient_background.dart';
import 'quest_venture_logo.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../widgets/quiz/question_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    const QuestVentureLogo(),
                    SizedBox(height: 30.h),
                    _buildAboutCard(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w, bottom: 32.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: VelittBranding(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return QuestionCard(
      child: Column(
        children: [
          Image.asset(
            'assets/images/backgrounds/aboutIcon.png',
            width: 320.w,
            height: 90.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 28.h),
          Image.asset(
            'assets/images/backgrounds/aboutIconQuest.png',
            width: 340.w,
            height: 110.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 28.h),
          Text(
            'QUEST VENTURE',
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontFamily: null,
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
              fontFamily: null,
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
              fontFamily: null,
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
              fontFamily: null,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                url: 'https://instagram.com/',
                iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
                tooltip: 'Instagram',
              ),
              SizedBox(width: 24.w),
              _buildSocialIcon(
                url: 'https://facebook.com/',
                iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                tooltip: 'Facebook',
              ),
              SizedBox(width: 24.w),
              _buildSocialIcon(
                url: 'https://wa.me/1234567890',
                iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png',
                tooltip: 'WhatsApp',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({required String url, required String iconUrl, required String tooltip}) {
    return InkWell(
      onTap: () async {
        await Helpers.launchURL(url);
      },
      child: Tooltip(
        message: tooltip,
        child: Image.network(
          iconUrl,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}



