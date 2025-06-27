import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/branding/quest_venture_logo.dart';

/// Welcome/Splash Screen - d11.jpeg
class WelcomeScreen extends StatelessWidget {
  final String userName;
  final String countryFlagUrl;
  final String languageName;
  final String languageFlagUrl;

  const WelcomeScreen({
    Key? key,
    required this.userName,
    required this.countryFlagUrl,
    required this.languageName,
    required this.languageFlagUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Bottom collage image (uncomment and set correct asset path if available)
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: Image.asset(
            //     'assets/images/backgrounds/bottom_collage.png',
            //     fit: BoxFit.cover,
            //     height: 180.h,
            //   ),
            // ),
            Column(
              children: [
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100.h,
                    child: Image.asset(
                      'assets/images/backgrounds/black_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 370.w,
                      height: 520.h,
                      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.r),
                        border: Border.all(color: Color(0xFF3498DB), width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'WELCOME BACK $userName !',
                            style: TextStyle(
                              color: Color(0xFF3498DB),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: 'LuckiestGuy',
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Image.network(countryFlagUrl, width: 32, height: 24, fit: BoxFit.contain),
                              SizedBox(width: 8.w),
                              Text(
                                languageName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildMenuButton(
                            context,
                            color: Color(0xFFE74C3C),
                            text: 'START QUEST',
                            iconAsset: 'assets/images/backgrounds/start_quest.png',
                            onTap: () {},
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 18.h),
                          _buildMenuButton(
                            context,
                            color: Colors.white,
                            text: 'LEADER BOARD',
                            iconAsset: 'assets/images/backgrounds/leader_board.png',
                            textColor: Color(0xFF3498DB),
                            borderColor: Color(0xFF3498DB),
                            onTap: () {},
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 18.h),
                          _buildMenuButton(
                            context,
                            color: Colors.white,
                            text: 'ABOUT US',
                            iconAsset: 'assets/images/backgrounds/about_us.png',
                            textColor: Color(0xFFF2B94C),
                            borderColor: Color(0xFFF2B94C),
                            onTap: () {},
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Powered by Velitt image at the bottom right
            Positioned(
              bottom: 16.h,
              right: 16.w,
              child: Image.asset(
                'assets/images/backgrounds/power_by_vellit.png',
                height: 40.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required Color color,
    required String text,
    String? iconAsset,
    Color textColor = Colors.white,
    Color borderColor = Colors.transparent,
    required VoidCallback onTap,
    double fontSize = 18,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          if (color != Colors.white)
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: onTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconAsset != null) ...[
                    Image.asset(iconAsset, width: 20, height: 20),
                    SizedBox(width: 6.w),
                  ],
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth - 40),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: 'LuckiestGuy',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}




class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/background.jpeg',
            fit: BoxFit.cover, // Fill screen without repeating
          ),
        ),

        // Foreground content
        child,
      ],
    );
  }
}
