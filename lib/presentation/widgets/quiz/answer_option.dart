import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final String? imageUrl;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: imageUrl != null ? _buildImageAnswer() : _buildTextAnswerBox(),
        ),
      ),
    );
  }

  Widget _buildTextAnswerBox() {
    return Container(
      width: double.infinity,
      height: 60.h, // Fixed height for consistent sizing
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: _buildTextAnswer(),
    );
  }

  Widget _buildTextAnswer() {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.primaryBlue,
              width: 3,
            ),
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20.sp,
                )
              : null,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageAnswer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Answer text above the row, indented to align with image
        Padding(
          padding: EdgeInsets.only(left: 32.w, bottom: 6.h), // 20w for checkbox + 12w spacing
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.textRed,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: null,
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox on the left
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : Colors.white,
                border: Border.all(
                  color: AppColors.primaryBlue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            // Image on the right
            Container(
              width: 110.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: isSelected
                    ? Border.all(color: AppColors.primaryBlue, width: 3)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 24.sp,
                            color: Colors.grey[600],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Image unavailable',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10.sp,
                              fontFamily: null,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
