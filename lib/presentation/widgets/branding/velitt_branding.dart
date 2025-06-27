import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VelittBranding extends StatelessWidget {
  final Color? textColor;
  final CrossAxisAlignment? alignment;
  final double? fontSize;

  const VelittBranding({
    super.key,
    this.textColor,
    this.alignment,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Powered by',
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: (fontSize ?? 10).sp,
          ),
        ),
        Text(
          'Velitt',
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: (fontSize != null ? fontSize! + 6 : 16).sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
