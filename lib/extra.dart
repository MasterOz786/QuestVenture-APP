//combined sign in screen


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/providers/auth_provider.dart';
// import '../../../core/providers/location_provider.dart';
// import '../../../core/utils/validators.dart';
// import '../../../core/utils/helpers.dart';
// import '../../../core/constants/image_constants.dart';
// import '../../widgets/common/gradient_background.dart';
// import '../../widgets/common/custom_button.dart';
// import '../../widgets/branding/quest_venture_logo.dart';
// import '../../widgets/branding/velitt_branding.dart';
// import '../../navigation/app_router.dart';

// class CombinedSignInScreen extends StatefulWidget {
//   const CombinedSignInScreen({super.key});

//   @override
//   State<CombinedSignInScreen> createState() => _CombinedSignInScreenState();
// }

// class _CombinedSignInScreenState extends State<CombinedSignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _countryController = TextEditingController();
//   final List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());
//   final List<FocusNode> _otpFocusNodes = List.generate(5, (index) => FocusNode());
  
//   bool _isOtpSent = false;
//   String _selectedCountry = '';

//   final List<Map<String, String>> _countries = [
//     {'name': 'United States', 'code': 'US', 'flag': '🇺🇸', 'dialCode': '+1'},
//     {'name': 'United Kingdom', 'code': 'UK', 'flag': '🇬🇧', 'dialCode': '+44'},
//     {'name': 'Canada', 'code': 'CA', 'flag': '🇨🇦', 'dialCode': '+1'},
//     {'name': 'Australia', 'code': 'AU', 'flag': '🇦🇺', 'dialCode': '+61'},
//     {'name': 'Germany', 'code': 'DE', 'flag': '🇩🇪', 'dialCode': '+49'},
//     {'name': 'France', 'code': 'FR', 'flag': '🇫🇷', 'dialCode': '+33'},
//     {'name': 'Spain', 'code': 'ES', 'flag': '🇪🇸', 'dialCode': '+34'},
//     {'name': 'Italy', 'code': 'IT', 'flag': '🇮🇹', 'dialCode': '+39'},
//   ];

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _countryController.dispose();
//     for (var controller in _otpControllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _otpFocusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GradientBackground(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 40.h),
//                 const QuestVentureLogo(),
//                 SizedBox(height: 30.h),
//                 _buildSignInCard(),
//                 SizedBox(height: 20.h),
//                 _buildBottomSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignInCard() {
//     return Container(
//       width: 350.w,
//       margin: EdgeInsets.symmetric(horizontal: 12.5.w),
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Welcome Header
//             Text(
//               'WELCOME TO QUEST VENTURE',
//               style: TextStyle(
//                 color: const Color(0xFF3498DB),
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.0,
//               ),
//               textAlign: TextAlign.center,
//             ),
            
//             SizedBox(height: 24.h),
            
//             // Sign In Title
//             Text(
//               'SIGN IN',
//               style: TextStyle(
//                 color: const Color(0xFFE74C3C),
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2.0,
//               ),
//             ),
            
//             SizedBox(height: 8.h),
            
//             Text(
//               'Please choose the language and Sign In',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14.sp,
//               ),
//               textAlign: TextAlign.center,
//             ),
            
//             SizedBox(height: 20.h),
            
//             // Language Dropdown
//             _buildLanguageDropdown(),
            
//             SizedBox(height: 16.h),
            
//             // Email Input
//             _buildEmailField(),
            
//             SizedBox(height: 16.h),
            
//             // Country Selection
//             _buildCountryField(),
            
//             SizedBox(height: 24.h),
            
//             // OTP Section (shown after email is entered)
//             if (_isOtpSent) ...[
//               Text(
//                 'ENTER CODE',
//                 style: TextStyle(
//                   color: const Color(0xFFE74C3C),
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.5,
//                 ),
//               ),
              
//               SizedBox(height: 8.h),
              
//               Text(
//                 'Please enter the one-time password sent to\nyour registered email.',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12.sp,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
              
//               SizedBox(height: 20.h),
              
//               _buildOtpFields(),
              
//               SizedBox(height: 24.h),
//             ],
            
//             // Continue Button
//             Consumer<AuthProvider>(
//               builder: (context, authProvider, child) {
//                 return _buildContinueButton(authProvider);
//               },
//             ),
            
//             if (context.watch<AuthProvider>().errorMessage != null) ...[
//               SizedBox(height: 16.h),
//               Text(
//                 context.watch<AuthProvider>().errorMessage!,
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 12.sp,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageDropdown() {
//     return Consumer<LocationProvider>(
//       builder: (context, locationProvider, child) {
//         return Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25.r),
//             border: Border.all(color: const Color(0xFF3498DB), width: 2),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               value: locationProvider.selectedLanguage,
//               isExpanded: true,
//               icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF3498DB), size: 20.sp),
//               style: TextStyle(color: Colors.black, fontSize: 14.sp),
//               items: locationProvider.languages.map((language) {
//                 return DropdownMenuItem<String>(
//                   value: language['name'],
//                   child: Row(
//                     children: [
//                       Text(language['flag']!, style: TextStyle(fontSize: 16.sp)),
//                       SizedBox(width: 12.w),
//                       Text(language['name']!, style: TextStyle(fontSize: 14.sp)),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   locationProvider.setLanguage(value);
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildEmailField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.r),
//         border: Border.all(color: const Color(0xFF3498DB), width: 2),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         style: TextStyle(fontSize: 14.sp, color: Colors.black),
//         decoration: InputDecoration(
//           hintText: 'Enter Your Email Here',
//           hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Email is required';
//           }
//           if (!Validators.isValidEmail(value)) {
//             return 'Please enter a valid email';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildCountryField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.r),
//         border: Border.all(color: const Color(0xFF3498DB), width: 2),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: _countryController,
//         readOnly: true,
//         style: TextStyle(fontSize: 14.sp, color: Colors.black),
//         decoration: InputDecoration(
//           hintText: 'Search & Select a Country',
//           hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//           suffixIcon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF3498DB)),
//         ),
//         onTap: _showCountryPicker,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please select a country';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildOtpFields() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(5, (index) {
//         return Container(
//           width: 50.w,
//           height: 50.h,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: index == 0 ? const Color(0xFFE74C3C) : const Color(0xFF3498DB),
//               width: 2,
//             ),
//             color: Colors.white,
//           ),
//           child: Center(
//             child: TextFormField(
//               controller: _otpControllers[index],
//               focusNode: _otpFocusNodes[index],
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               maxLength: 1,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: index == 0 ? const Color(0xFFE74C3C) : const Color(0xFF3498DB),
//               ),
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 counterText: '',
//               ),
//               onChanged: (value) {
//                 if (value.isNotEmpty && index < 4) {
//                   _otpFocusNodes[index + 1].requestFocus();
//                 } else if (value.isEmpty && index > 0) {
//                   _otpFocusNodes[index - 1].requestFocus();
//                 }
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildContinueButton(AuthProvider authProvider) {
//     return Container(
//       width: double.infinity,
//       height: 50.h,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFFE74C3C), Color(0xFFE67E22)],
//         ),
//         borderRadius: BorderRadius.circular(25.r),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFFE74C3C).withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(25.r),
//           onTap: authProvider.isLoading ? null : _handleContinue,
//           child: Center(
//             child: authProvider.isLoading
//                 ? SizedBox(
//                     width: 20.w,
//                     height: 20.h,
//                     child: const CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : Text(
//                     'CONTINUE',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomSection() {
//     return SizedBox(height: 20.h);
//   }

//   void _showCountryPicker() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (context) {
//         return Container(
//           height: 400.h,
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             children: [
//               Text(
//                 'Select Country',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _countries.length,
//                   itemBuilder: (context, index) {
//                     final country = _countries[index];
//                     return ListTile(
//                       leading: Text(
//                         country['flag']!,
//                         style: TextStyle(fontSize: 24.sp),
//                       ),
//                       title: Text(country['name']!),
//                       subtitle: Text(country['dialCode']!),
//                       onTap: () {
//                         setState(() {
//                           _selectedCountry = country['name']!;
//                           _countryController.text = country['name']!;
//                         });
//                         Navigator.pop(context);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _handleContinue() async {
//     if (!_isOtpSent) {
//       // First step: Send OTP
//       if (_formKey.currentState!.validate()) {
//         final authProvider = context.read<AuthProvider>();
//         final success = await authProvider.signIn(_emailController.text.trim());
        
//         if (success) {
//           setState(() {
//             _isOtpSent = true;
//           });
//           Helpers.showSnackBar(context, 'OTP sent to your email');
//         } else if (mounted) {
//           Helpers.showSnackBar(
//             context,
//             authProvider.errorMessage ?? 'Failed to send OTP',
//             isError: true,
//           );
//         }
//       }
//     } else {
//       // Second step: Verify OTP
//       final otp = _otpControllers.map((controller) => controller.text).join();
      
//       if (otp.length == 5) {
//         final authProvider = context.read<AuthProvider>();
//         final success = await authProvider.verifyOtp(_emailController.text.trim(), otp);
        
//         if (success && mounted) {
//           Navigator.pushReplacementNamed(context, AppRouter.location);
//         } else if (mounted) {
//           Helpers.showSnackBar(
//             context,
//             authProvider.errorMessage ?? 'Invalid OTP',
//             isError: true,
//           );
//         }
//       } else {
//         Helpers.showSnackBar(context, 'Please enter complete OTP', isError: true);
//       }
//     }
//   }
// }





// sing in screen

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../core/providers/auth_provider.dart';
// import '../../../core/providers/location_provider.dart';
// import '../../../core/utils/validators.dart';
// import '../../../core/utils/helpers.dart';
// import '../../../core/constants/image_constants.dart';
// import '../../../core/services/email_service.dart';
// import '../../widgets/common/gradient_background.dart';
// import '../../widgets/branding/quest_venture_logo.dart';
// import '../../widgets/branding/velitt_branding.dart';
// import '../../navigation/app_router.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());
//   final List<FocusNode> _otpFocusNodes = List.generate(5, (index) => FocusNode());

//   List<Map<String, dynamic>> _countryList = [];
//   String? _selectedCountryFlag;
//   String? _selectedCountryName;
//   bool _isLoadingCountries = false;
//   bool _isOtpSent = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCountries();
//   }

//   Future<void> _fetchCountries() async {
//     setState(() { _isLoadingCountries = true; });
//     try {
//       final response = await http.get(Uri.parse('assets/countries/countriesList.php'));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           _countryList = data.cast<Map<String, dynamic>>();
//         });
//       }
//     } catch (e) {
//       // Handle error
//     } finally {
//       setState(() { _isLoadingCountries = false; });
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     for (var controller in _otpControllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _otpFocusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFFF15A4A), Color(0xFF4FC3F7)],
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 32.h),
//                       // Black logo at the top
//                       Container(
//                         margin: EdgeInsets.only(bottom: 16.h),
//                         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(30.r),
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         child: Image.asset(
//                           'assets/images/backgrounds/black_logo.png',
//                           height: 40.h,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       _buildSignInCard(),
//                       SizedBox(height: 60.h),
//                     ],
//                   ),
//                 ),
//                 // Powered by Velitt image at the bottom right
//                 Positioned(
//                   bottom: 16.h,
//                   right: 16.w,
//                   child: Image.asset(
//                     'assets/images/backgrounds/power_by_vellit.png',
//                     height: 40.h,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignInCard() {
//     return Container(
//       width: 350.w,
//       margin: EdgeInsets.symmetric(horizontal: 12.5.w),
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Text(
//               'WELCOME TO QUEST VENTURE',
//               style: TextStyle(
//                 color: Color(0xFF3498DB),
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.0,
//                 fontFamily: 'LuckiestGuy',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'SIGN IN',
//               style: TextStyle(
//                 color: Color(0xFFE74C3C),
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2.0,
//                 fontFamily: 'LuckiestGuy',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               'Please choose the language and Sign In',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14.sp,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20.h),
//             _buildCountryField(),
//             SizedBox(height: 16.h),
//             _buildEmailField(),
//             SizedBox(height: 24.h),
//             if (_isOtpSent) ...[
//               Text(
//                 'ENTER CODE',
//                 style: TextStyle(
//                   color: Color(0xFFE74C3C),
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.5,
//                   fontFamily: 'LuckiestGuy',
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Text(
//                 'Please enter the one-time password sent to your registered email.',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 12.sp,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20.h),
//               _buildOtpFields(),
//               SizedBox(height: 16.h),
//             ],
//             _buildContinueButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCountryField() {
//     return GestureDetector(
//       onTap: _showCountryPicker,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.r),
//           border: Border.all(color: Color(0xFF3498DB), width: 2),
//           color: Colors.white,
//         ),
//         child: Row(
//           children: [
//             if (_selectedCountryFlag != null)
//               Image.network(_selectedCountryFlag!, width: 28.w, height: 20.h, fit: BoxFit.contain),
//             if (_selectedCountryFlag != null) SizedBox(width: 8.w),
//             Expanded(
//               child: Text(
//                 _selectedCountryName ?? 'Search & Select a Country',
//                 style: TextStyle(
//                   color: _selectedCountryName == null ? Colors.grey[400] : Colors.black,
//                   fontSize: 14.sp,
//                 ),
//               ),
//             ),
//             Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.r),
//         border: Border.all(color: Color(0xFF3498DB), width: 2),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         style: TextStyle(fontSize: 14.sp, color: Colors.black),
//         decoration: InputDecoration(
//           hintText: 'Enter Your Email Here',
//           hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Email is required';
//           }
//           if (!Validators.isValidEmail(value)) {
//             return 'Please enter a valid email';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildOtpFields() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(5, (index) {
//         return Container(
//           width: 50.w,
//           height: 50.h,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: index == 0 ? Color(0xFFE74C3C) : Color(0xFF3498DB),
//               width: 2,
//             ),
//             color: Colors.white,
//           ),
//           child: Center(
//             child: TextFormField(
//               controller: _otpControllers[index],
//               focusNode: _otpFocusNodes[index],
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               maxLength: 1,
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.bold,
//                 color: index == 0 ? Color(0xFFE74C3C) : Color(0xFF3498DB),
//               ),
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 counterText: '',
//               ),
//               onChanged: (value) {
//                 if (value.isNotEmpty && index < 4) {
//                   _otpFocusNodes[index + 1].requestFocus();
//                 } else if (value.isEmpty && index > 0) {
//                   _otpFocusNodes[index - 1].requestFocus();
//                 }
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildContinueButton() {
//     return Container(
//       width: double.infinity,
//       height: 50.h,
//       margin: EdgeInsets.only(top: 24.h),
//       decoration: BoxDecoration(
//         color: Color(0xFFE74C3C),
//         borderRadius: BorderRadius.circular(25.r),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFFE74C3C).withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(25.r),
//           onTap: _handleContinue,
//           child: Center(
//             child: Text(
//               'CONTINUE',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.5,
//                 fontFamily: 'LuckiestGuy',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCountryPicker() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (context) {
//         if (_isLoadingCountries) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return Container(
//           height: 400.h,
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             children: [
//               Text(
//                 'Select Country',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _countryList.length,
//                   itemBuilder: (context, index) {
//                     final country = _countryList[index];
//                     return ListTile(
//                       leading: country['flag'] != null
//                         ? Image.network(country['flag'], width: 28.w, height: 20.h, fit: BoxFit.contain)
//                         : null,
//                       title: Text(country['name'] ?? ''),
//                       onTap: () {
//                         setState(() {
//                           _selectedCountryName = country['name'];
//                           _selectedCountryFlag = country['flag'];
//                         });
//                         Navigator.pop(context);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _handleContinue() async {
//     if (!_isOtpSent) {
//       // First step: Send OTP
//       if (_formKey.currentState!.validate()) {
//         final authProvider = context.read<AuthProvider>();
//         final success = await authProvider.signIn(_emailController.text.trim());

//         if (success) {
//           setState(() {
//             _isOtpSent = true;
//           });
//           Helpers.showSnackBar(context, 'OTP sent to your email');
//         } else if (mounted) {
//           Helpers.showSnackBar(
//             context,
//             authProvider.errorMessage ?? 'Failed to send OTP',
//             isError: true,
//           );
//         }
//       }
//     } else {
//       // Second step: Verify OTP
//       final otp = _otpControllers.map((controller) => controller.text).join();

//       if (otp.length == 5) {
//         final authProvider = context.read<AuthProvider>();
//         final success = await authProvider.verifyOtp(_emailController.text.trim(), otp);

//         if (success && mounted) {
//           Navigator.pushReplacementNamed(context, AppRouter.location);
//         } else if (mounted) {
//           Helpers.showSnackBar(
//             context,
//             authProvider.errorMessage ?? 'Invalid OTP',
//             isError: true,
//           );
//         }
//       } else {
//         Helpers.showSnackBar(context, 'Please enter complete OTP', isError: true);
//       }
//     }
//   }
// }
