import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../splash/gradient_background.dart';
import '../splash/quest_venture_logo.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/branding/velitt_branding.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  int _countdown = 1; // Changed to 12 to match the design
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print('Ad screen initialized with countdown: $_countdown');
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        print('Countdown finished, auto-skipping ad');
        _skipAd();
      }
    });
  }

  void _skipAd() {
    print('Skipping ad and returning to quiz');
    _timer?.cancel();
    if (mounted) {
      // Return to the previous screen (quiz screen)
      Navigator.pop(context, 'ad_completed');
    }
  }

  @override
  void dispose() {
    print('Ad screen disposed');
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                SizedBox(height: 60.h), // Status bar space
                
                // Header with black logo
                const QuestVentureLogo(),
                
                SizedBox(height: 40.h),
                
                // Ad card
                Expanded(
                  child: Container(
                    width: 350.w,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(32.r),
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
                        // Large ad image section
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              image: const DecorationImage(
                                image: NetworkImage(ImageConstants.networkAdPerson),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // McDonald's logo
                                Positioned(
                                  top: 20.h,
                                  left: 20.w,
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Skip button at bottom
                        Container(
                          width: double.infinity,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE74C3C),
                            borderRadius: BorderRadius.circular(32.r),
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
                              borderRadius: BorderRadius.circular(32.r),
                              onTap: _countdown == 0 ? _skipAd : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _countdown > 0
                                        ? 'SKIP AD IN ${(_countdown ~/ 60).toString().padLeft(2, '0')}:${(_countdown % 60).toString().padLeft(2, '0')}'
                                        : 'SKIP AD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Beachday',
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 120.h), // Space for background and powered by text
                // Powered by Velitt at the bottom right
                Padding(
                  padding: EdgeInsets.only(right: 20.w, bottom: 32.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: VelittBranding(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
