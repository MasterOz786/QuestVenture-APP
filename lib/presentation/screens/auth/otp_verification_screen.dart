import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../navigation/app_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                const QuestVentureLogo(),
                SizedBox(height: 60.h),
                _buildOtpCard(),
                SizedBox(height: 40.h),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpCard() {
    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
      padding: EdgeInsets.all(32.w),
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'VERIFY OTP',
              style: TextStyle(
                color: const Color(0xFF3498DB),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Enter the 4-digit code sent to\n${Helpers.formatPhoneNumber(widget.phoneNumber)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            CustomTextField(
              controller: _otpController,
              hintText: 'Enter OTP',
              keyboardType: TextInputType.number,
              validator: Validators.validateOtp,
              prefixIcon: Icon(
                Icons.lock,
                color: const Color(0xFF3498DB),
                size: 20.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return CustomButton(
                  text: 'VERIFY',
                  isLoading: authProvider.isLoading,
                  onPressed: _handleVerifyOtp,
                );
              },
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: _handleResendOtp,
              child: Text(
                'Resend OTP',
                style: TextStyle(
                  color: const Color(0xFF3498DB),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (context.watch<AuthProvider>().errorMessage != null) ...[
              SizedBox(height: 16.h),
              Text(
                context.watch<AuthProvider>().errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=400&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: VelittBranding(),
        ),
      ),
    );
  }

  void _handleVerifyOtp() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.verifyOtp(
        widget.phoneNumber,
        _otpController.text.trim(),
      );
      
      if (success && mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.location);
      } else if (mounted) {
        Helpers.showSnackBar(
          context,
          authProvider.errorMessage ?? 'Invalid OTP',
          isError: true,
        );
      }
    }
  }

  void _handleResendOtp() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.signIn(widget.phoneNumber);
    
    if (mounted) {
      Helpers.showSnackBar(context, 'OTP sent successfully');
    }
  }
}
