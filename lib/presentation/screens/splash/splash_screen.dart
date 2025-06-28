import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/image_constants.dart';
import 'gradient_background.dart';
import '../../navigation/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _slideController.forward();
    
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.signIn);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            _buildAdventureIcons(),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        _buildMainLogo(),
                        SizedBox(height: 60.h),
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildWelcomeBanner(),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
            // Powered by text
            Positioned(
              bottom: 32.h,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Powered By',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: '',
                    ),
                  ),
                  Text(
                    'Velitt',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdventureIcons() {
    return Stack(
      children: [
        Positioned(
          top: 100.h,
          left: 50.w,
          child: _buildFloatingIcon(Icons.cloud_outlined, 0.3),
        ),
        Positioned(
          top: 150.h,
          right: 80.w,
          child: _buildFloatingIcon(Icons.cloud_outlined, 0.2),
        ),
        Positioned(
          top: 200.h,
          left: 150.w,
          child: _buildFloatingIcon(Icons.cloud_outlined, 0.25),
        ),
        Positioned(
          top: 120.h,
          left: 20.w,
          child: _buildFloatingIcon(Icons.camera_alt_outlined, 0.4),
        ),
        Positioned(
          top: 180.h,
          right: 30.w,
          child: _buildFloatingIcon(Icons.location_on_outlined, 0.35),
        ),
        Positioned(
          top: 140.h,
          right: 100.w,
          child: _buildDottedPath(),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, double opacity) {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Opacity(
          opacity: opacity * _fadeAnimation.value,
          child: Icon(
            icon,
            color: Colors.white,
            size: 24.sp,
          ),
        );
      },
    );
  }

  Widget _buildDottedPath() {
    return CustomPaint(
      size: Size(100.w, 50.h),
      painter: DottedPathPainter(),
    );
  }

  Widget _buildMainLogo() {
    return Image.asset(
      'assets/images/backgrounds/white_logo.png',
      width: 220.w,
    );
  }

  Widget _buildWelcomeBanner() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD966),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'WELCOME TO SCAVENGER HUNT',
          textAlign: TextAlign.center,
          softWrap: false,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class DottedPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
