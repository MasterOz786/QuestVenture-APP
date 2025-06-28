import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestVentureLogo extends StatelessWidget {
  const QuestVentureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/backgrounds/black_logo.png',
      width: 350.w,
      fit: BoxFit.contain,
    );
  }
} 