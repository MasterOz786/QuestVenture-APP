import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/location_provider.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/branding/quest_venture_logo.dart';
import '../../widgets/branding/velitt_branding.dart';
import '../../navigation/app_router.dart';

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                const QuestVentureLogo(),
                SizedBox(height: 30.h),
                _buildLocationCard(),
                SizedBox(height: 20.h),
                _buildBottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      width: 350.w,
      margin: EdgeInsets.symmetric(horizontal: 12.5.w),
      padding: EdgeInsets.all(24.w),
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
      child: Column(
        children: [
          Text(
            'GET STARTED WITH THE QUEST',
            style: TextStyle(
              color: const Color(0xFF3498DB),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            'LOCATION',
            style: TextStyle(
              color: const Color(0xFFE74C3C),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Confirm or select your location.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          _buildLanguageDropdown(),
          SizedBox(height: 20.h),
          _buildMapSection(),
          SizedBox(height: 30.h),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: locationProvider.selectedLanguage,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600], size: 20.sp),
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
              items: locationProvider.languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['name'],
                  child: Row(
                    children: [
                      Text(language['flag']!, style: TextStyle(fontSize: 18.sp)),
                      SizedBox(width: 12.w),
                      Text(language['name']!),
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

  Widget _buildMapSection() {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xFF3498DB), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.r),
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
                size: 40.sp,
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'See Location in Google Maps',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return CustomButton(
          text: 'CONTINUE TO QUEST',
          isLoading: locationProvider.isLoading,
          onPressed: _handleContinue,
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(ImageConstants.networkAdventure),
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
