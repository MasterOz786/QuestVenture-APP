import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/location_provider.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/utils/helpers.dart';
import '../splash/gradient_background.dart';
import '../splash/quest_venture_logo.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../navigation/app_router.dart';
import 'quiz_screen.dart';
import 'quiz_completion_screen.dart';
import 'ad_screen.dart';
import '../../../core/theme/app_colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                SizedBox(height: 60.h), // Status bar space
                
                // Header with logo
                Container(
                  width: 350.w,
                  height: 80.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  ),
                  child: const QuestVentureLogo(),
                ),
                
                SizedBox(height: 40.h),
                
                // Main location card
                Expanded(
                  child: Container(
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
                    child: Column(
                      children: [
                        // Title
                        Text(
                          'GET STARTED WITH THE QUEST',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.0,
                            decoration: TextDecoration.none,
                            fontFamily: null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Map section with larger height
                        Container(
                          width: double.infinity,
                          height: 250.h, // Increased height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: const Color(0xFF3498DB), width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17.r),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(ImageConstants.networkMap),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: const Color(0xFFE74C3C),
                                    size: 50.sp, // Larger location icon
                                  ),
                                ),
                                Positioned(
                                  bottom: 20.h,
                                  left: 20.w,
                                  right: 20.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                    child: Text(
                                      'See Location in Google Maps',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: null,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Location section title
                        Text(
                          'LOCATION',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.0,
                            decoration: TextDecoration.none,
                            fontFamily: null,
                          ),
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        Text(
                          'Confirm or select your location.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            fontFamily: null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Language dropdown with increased height
                        _buildLanguageDropdown(),
                        
                        const Spacer(),
                        
                        // Continue button
                        _buildContinueButton(),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 120.h), // Space for background and powered by text
              ],
            ),
            
            // Powered by text
            Positioned(
              bottom: 220.h,
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

  Widget _buildLanguageDropdown() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          width: double.infinity,
          height: 60.h, // Increased height
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: const Color(0xFF3498DB), width: 3),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: locationProvider.selectedLanguage,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF3498DB), size: 24.sp),
              style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: null),
              items: locationProvider.languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['name'],
                  child: Row(
                    children: [
                      Text(language['flag']!, style: TextStyle(fontSize: 20.sp, fontFamily: null)),
                      SizedBox(width: 12.w),
                      Text(
                        language['name']!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  locationProvider.setLanguage(value);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return CustomButton(
          text: 'CONTINUE TO QUEST',
          isLoading: locationProvider.isLoading,
          onPressed: _handleContinue,
          gradientColors: [Color(0xFFE74C3C), Color(0xFFE74C3C)],
        );
      },
    );
  }

  void _handleContinue() async {
    final locationProvider = context.read<LocationProvider>();
    final success = await locationProvider.confirmLocation();
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.quiz);
    } else if (mounted) {
      Helpers.showSnackBar(
        context,
        locationProvider.errorMessage ?? 'Failed to confirm location',
        isError: true,
      );
    }
  }
}
