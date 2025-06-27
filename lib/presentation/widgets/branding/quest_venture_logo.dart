import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestVentureLogo extends StatelessWidget {
  const QuestVentureLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/backgrounds/white_logo.png',
        width: 300.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
