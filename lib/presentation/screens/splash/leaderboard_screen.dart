import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gradient_background.dart';
import 'quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../../core/theme/app_colors.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboard = const [
    {'rank': 1, 'name': 'EJAZ UDDIN', 'score': 1500},
    {'rank': 2, 'name': 'ROEN KHAN', 'score': 1500},
    {'rank': 3, 'name': 'MOIN KHAN', 'score': 1500},
    {'rank': 4, 'name': 'ARBAZ ULLAH', 'score': 1500},
    {'rank': 5, 'name': 'LINA HUSSAIN', 'score': 1400},
    {'rank': 6, 'name': 'RAVI KAPOOR', 'score': 1300},
  ];

  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    const QuestVentureLogo(),
                    SizedBox(height: 30.h),
                    _buildLeaderboardCard(context),
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
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(BuildContext context) {
    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundDark,
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
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE74C3C),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/backgrounds/leader_board.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 12.w),
                Text(
                  'LEADERBOARD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Beachday',
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          ...leaderboard.map((entry) => _buildLeaderboardEntry(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildLeaderboardEntry(Map<String, dynamic> entry) {
    Widget? rankLogo;
    bool isTopThree = false;
    if (entry['rank'] == 1) {
      rankLogo = Image.asset(
        'assets/images/backgrounds/first.png',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
      isTopThree = true;
    } else if (entry['rank'] == 2) {
      rankLogo = Image.asset(
        'assets/images/backgrounds/second.png',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
      isTopThree = true;
    } else if (entry['rank'] == 3) {
      rankLogo = Image.asset(
        'assets/images/backgrounds/third.png',
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
      isTopThree = true;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: const Color(0xFF3498DB), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isTopThree)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                rankLogo!,
                SizedBox(width: 6.w),
                Text(
                  entry['name'],
                  style: TextStyle(
                    color: const Color(0xFF3498DB),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Beachday',
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          else
            Text(
              entry['name'],
              style: TextStyle(
                color: const Color(0xFF3498DB),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Beachday',
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 8.h),
          Text(
            'SCORE: ${entry['score']}',
            style: TextStyle(
              color: const Color(0xFFE74C3C),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Beachday',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 
