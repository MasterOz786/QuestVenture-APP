import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gradient_background.dart';
import '../../../assets/countries/countriesList.dart';
import '../../../presentation/screens/splash/start_quest.dart';
import '../../screens/splash/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../../core/theme/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(5, (index) => FocusNode());

  String? _selectedCountryFlag;
  String? _selectedCountryName;
  Map<String, String>? _selectedCountry;
  String? _selectedLanguageName = 'English UK';
  bool _isOtpSent = false;

  @override
  void initState() {
    super.initState();
    // Set default country to Netherlands
    final netherlands = countriestList.firstWhere(
      (country) => country['name']?.toLowerCase() == 'netherlands',
      orElse: () => countriestList[0],
    );
    _selectedCountry = netherlands;
    _selectedCountryFlag = netherlands['flag'];
    _selectedCountryName = netherlands['name'];
    // Set default values to show the design
    _emailController.text = '';
    _isOtpSent = true; // Show OTP section by default to match design
  }

  @override
  void dispose() {
    _emailController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    // Header with logo
                    const QuestVentureLogo(),
                    SizedBox(height: 40.h),
                    // Main white container
                    Container(
                      width: 350.w,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundDark,
                        borderRadius: BorderRadius.circular(32.r),
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
                            // Welcome text
                            Text(
                              'WELCOME TO QUEST VENTURE',
                              style: TextStyle(
                                color: const Color(0xFF3498DB),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                fontFamily: 'Beachday',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            // Sign In text
                            Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: const Color(0xFFE74C3C),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontFamily: 'Beachday',
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Subtitle
                            Text(
                              'Please choose the language and Sign In',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: '',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            // Country flag and name row (no dropdown, just display)
                            Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  if (_selectedCountryFlag != null)
                                    Image.network(
                                      _selectedCountryFlag!,
                                      width: 32,
                                      height: 24,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 32,
                                          height: 24,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.flag, size: 16),
                                        );
                                      },
                                    ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      _selectedCountryName ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontFamily: '',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Email field
                            _buildEmailField(),
                            SizedBox(height: 16.h),
                            // Country field
                            _buildCountryField(),
                            SizedBox(height: 30.h),
                            // Enter Code section
                            Text(
                              'ENTER CODE',
                              style: TextStyle(
                                color: const Color(0xFFE74C3C),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: 'Beachday',
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Please enter the one-time password sent to your registered email.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: '',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            // OTP fields
                            _buildOtpFields(),
                            SizedBox(height: 30.h),
                            // Continue button
                            _buildContinueButton(),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 120.h), // Space for background and powered by text
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

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: const Color(0xFF3498DB), width: 3),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 16.sp, color: Colors.black, fontFamily: ''),
        decoration: InputDecoration(
          hintText: 'Enter Your Email Here',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.sp, fontFamily: ''),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCountryField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: const Color(0xFF3498DB), width: 3),
      ),
      child: GestureDetector(
        onTap: _showCountryPicker,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              // Show selected country flag if available
              if (_selectedCountryFlag != null) ...[
                Image.network(
                  _selectedCountryFlag!,
                  width: 28,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 20, color: Colors.grey),
                ),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  _selectedCountryName ?? 'Search & Select a Country',
                  style: TextStyle(
                    color: _selectedCountryName == null ? Colors.grey[400] : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: _selectedCountryName == null ? FontWeight.normal : FontWeight.w600,
                    fontFamily: '',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: index == 0 ? const Color(0xFFE74C3C) : const Color(0xFF3498DB),
              width: 3,
            ),
          ),
          child: TextFormField(
            controller: _otpControllers[index],
            focusNode: _otpFocusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: ''),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            onChanged: (val) {
              if (val.isNotEmpty && index < 4) {
                FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildContinueButton() {
    return Container(
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
          onTap: _handleContinue,
          child: Center(
            child: Text(
              'CONTINUE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Beachday',
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Country', style: TextStyle(fontFamily: '')),
        content: Container(
          width: double.maxFinite,
          height: 300.h,
          child: ListView.builder(
            itemCount: countriestList.length,
            itemBuilder: (context, index) {
              final country = countriestList[index];
              return ListTile(
                leading: Image.network(
                  country['flag']!,
                  width: 28,
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 20, color: Colors.grey),
                ),
                title: Text(
                  country['name']!,
                  style: TextStyle(fontFamily: ''),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  setState(() {
                    _selectedCountry = country;
                    _selectedCountryFlag = country['flag'];
                    _selectedCountryName = country['name'];
                  });
                  Navigator.pop(context);
                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${country['name']}', style: TextStyle(fontFamily: '')),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (!_isOtpSent) {
      // First step: Send OTP
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isOtpSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome to Quest Venture')),
        );
      }
    } else {
      // Second step: Verify OTP
      final otp = _otpControllers.map((controller) => controller.text).join();
      if (otp.length == 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome to Quest Venture')),
        );
        // Navigate to StartQuestScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StartQuestScreen(
              userName: _emailController.text,
              countryFlagUrl: _selectedCountryFlag ?? '',
              languageName: _selectedCountryName ?? '',
              selectedCountry: _selectedCountry!,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter complete OTP'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
