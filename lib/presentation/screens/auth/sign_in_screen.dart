import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/common/gradient_background.dart';
import '../../countries/countries.dart';
import '../../screens/splash/welcome_screen.dart';

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

  List<Map<String, dynamic>> _countryList = [];
  String? _selectedCountryFlag;
  String? _selectedCountryName;
  bool _isOtpSent = false;
  String? _selectedLanguageFlag = 'https://flagcdn.com/24x18/gb.png';
  String? _selectedLanguageName = 'English UK';

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  void _fetchCountries() {
    // Use the new countriesList with flags
    _countryList = countriesList;
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
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    // Black logo at the top
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100.h,
                        child: Image.asset(
                          'assets/images/backgrounds/black_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    _buildSignInCard(),
                    SizedBox(height: 60.h),
                  ],
                ),
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
      ),
    );
  }

  Widget _buildSignInCard() {
    return Container(
      width: 370.w,
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'WELCOME TO QUEST VENTURE',
              style: TextStyle(
                color: Color(0xFF3498DB),
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontFamily: 'LuckiestGuy',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              'SIGN IN',
              style: TextStyle(
                color: Color(0xFFE74C3C),
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                fontFamily: 'LuckiestGuy',
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Please choose the language and Sign In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            _buildLanguageDropdown(),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(child: _buildEmailField()),
              ],
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(child: _buildCountryField()),
              ],
            ),
            SizedBox(height: 28.h),
            Text(
              'ENTER CODE',
              style: TextStyle(
                color: Color(0xFFE74C3C),
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: 'LuckiestGuy',
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please enter the one-time password sent to your registered email.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            _buildOtpFields(),
            SizedBox(height: 28.h),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedCountryFlag != null && _selectedCountryName != null)
              ...[
                Image.network(_selectedCountryFlag!, width: 24, height: 18, fit: BoxFit.contain),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    _selectedCountryName!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]
            else ...[
              Image.network(_selectedLanguageFlag!, width: 24, height: 18, fit: BoxFit.contain),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  _selectedLanguageName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Color(0xFF3498DB), width: 2),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 15.sp, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Enter Your Email Here',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          // Add your email validation logic here
          return null;
        },
      ),
    );
  }

  Widget _buildCountryField() {
    return GestureDetector(
      onTap: _showCountryPicker,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: Color(0xFF3498DB), width: 2),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_selectedCountryFlag != null)
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Image.network(
                  _selectedCountryFlag!,
                  width: 24,
                  height: 18,
                  fit: BoxFit.contain,
                ),
              ),
            Expanded(
              child: Text(
                _selectedCountryName ?? 'Search & Select a Country',
                style: TextStyle(
                  color: _selectedCountryName == null ? Colors.grey[400] : Colors.black,
                  fontSize: 15.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
            SizedBox(width: 12.w),
          ],
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
              color: index == 0 ? Color(0xFFE74C3C) : Color(0xFF3498DB),
              width: 2.5,
            ),
            color: Colors.white,
          ),
          child: Center(
            child: TextFormField(
              controller: _otpControllers[index],
              focusNode: _otpFocusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: index == 0 ? Color(0xFFE74C3C) : Color(0xFF3498DB),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 4) {
                  _otpFocusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  _otpFocusNodes[index - 1].requestFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Color(0xFFE74C3C),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE74C3C).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(
                  userName: _emailController.text.isNotEmpty ? _emailController.text.split('@')[0] : 'User',
                  countryFlagUrl: _selectedCountryFlag ?? 'https://flagcdn.com/24x18/gb.png',
                  languageName: _selectedCountryName ?? _selectedLanguageName ?? 'English UK',
                  languageFlagUrl: _selectedCountryFlag ?? _selectedLanguageFlag ?? 'https://flagcdn.com/24x18/gb.png',
                ),
              ),
            );
          },
          child: Center(
            child: Text(
              'CONTINUE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: 'LuckiestGuy',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          height: 400.h,
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text(
                'Select Country',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _countryList.length,
                  itemBuilder: (context, index) {
                    final country = _countryList[index];
                    return ListTile(
                      leading: country['flag'] != null
                        ? Image.network(country['flag'], width: 20, height: 15, fit: BoxFit.contain)
                        : null,
                      title: Text(country['name'] ?? ''),
                      onTap: () {
                        setState(() {
                          _selectedCountryName = country['name'];
                          _selectedCountryFlag = country['flag'];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
