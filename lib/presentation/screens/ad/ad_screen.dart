import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  int _countdown = AppConstants.adCountdownDuration;
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
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        const QuestVentureLogo(),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: _buildAdCard(constraints),
                        ),
                        SizedBox(height: 10.h),
                        _buildBottomSection(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAdCard(BoxConstraints constraints) {
    // Calculate available height for the ad card
    final availableHeight = constraints.maxHeight - 200.h; // Reserve space for logo and bottom
    final cardHeight = availableHeight.clamp(400.h, 600.h);

    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
      padding: EdgeInsets.all(20.w),
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
          // Ad Image/Video Section
          Expanded(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: cardHeight * 0.75, // 75% of card height for image
                minHeight: 250.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: const DecorationImage(
                  image: NetworkImage(ImageConstants.networkAdPerson),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // McDonald's logo
                  Positioned(
                    top: 15.h,
                    left: 15.w,
                    child: Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(17.5.r),
                      ),
                      child: Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.sp,
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

          SizedBox(height: 20.h),

          // Skip Ad Button
          CustomButton(
            text: _countdown > 0
                ? 'SKIP AD IN ${(_countdown ~/ 60).toString().padLeft(2, '0')}:${(_countdown % 60).toString().padLeft(2, '0')}'
                : 'SKIP AD',
            icon: Icons.skip_next,
            onPressed: _countdown == 0 ? _skipAd : null,
            height: 45.h,
          ),

          // Debug info (remove in production)
          if (_countdown > 0) ...[
            SizedBox(height: 10.h),
            Text(
              'Ad will auto-skip in $_countdown seconds',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return SizedBox(height: 20.h);
  }
}
