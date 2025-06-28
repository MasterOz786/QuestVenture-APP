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
import '../../../assets/countries/countriesList.dart';
import '../../../core/theme/app_colors.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, String> selectedCountry;
  const LocationScreen({super.key, required this.selectedCountry});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Map<String, String>? _selectedCountry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getCurrentLocation();
    });
    _selectedCountry = widget.selectedCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  const QuestVentureLogo(),
                  SizedBox(height: 30.h),
                  _buildLocationCard(),
                  SizedBox(height: 120.h),
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
        ),
      ],
    );
  }

  // Widget _buildLocationCard() {
  //   return Container(
  //     width: 350.w,
  //     margin: EdgeInsets.symmetric(horizontal: 12.5.w),
  //     padding: EdgeInsets.all(24.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(25.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 20,
  //           offset: const Offset(0, 10),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           'GET STARTED WITH THE QUEST',
  //           style: TextStyle(
  //             color: const Color(0xFF3498DB),
  //             fontSize: 18.sp,
  //             fontWeight: FontWeight.bold,
  //             letterSpacing: 1.0,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(height: 20.h),
  //         Text(
  //           'LOCATION',
  //           style: TextStyle(
  //             color: const Color(0xFFE74C3C),
  //             fontSize: 24.sp,
  //             fontWeight: FontWeight.bold,
  //             letterSpacing: 2.0,
  //           ),
  //         ),
  //         SizedBox(height: 12.h),
  //         Text(
  //           'Confirm or select your location.',
  //           style: TextStyle(
  //             color: Colors.grey[600],
  //             fontSize: 14.sp,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(height: 20.h),
  //         _buildCountryPicker(),
  //         SizedBox(height: 20.h),
  //         _buildMapSection(),
  //         SizedBox(height: 30.h),
  //         _buildContinueButton(),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildLocationCard() {
  return Container(
    width: 350.w,
    margin: EdgeInsets.symmetric(horizontal: 12.5.w),
    padding: EdgeInsets.all(32.w), // Increased from 24.w
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
        Text(
          'GET STARTED WITH THE QUEST',
          style: TextStyle(
            color: Color(0xFF3498DB),
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Beachday',
            letterSpacing: 1.0,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h), // Increased from 20.h
        Text(
          'LOCATION',
          style: TextStyle(
            color: Color(0xFFE74C3C),
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Beachday',
            letterSpacing: 1.0,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 20.h), // Increased from 12.h
        Text(
          'Confirm or select your location.',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            fontFamily: null,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30.h), // Increased from 20.h
        _buildCountryPicker(),
        SizedBox(height: 30.h), // Increased from 20.h
        _buildMapSection(),
        SizedBox(height: 40.h), // Increased from 30.h
        _buildContinueButton(),
      ],
    ),
  );
}

  Widget _buildCountryPicker() {
    return GestureDetector(
      onTap: _showCountryPickerDialog,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            if (_selectedCountry != null)
              Image.network(
                _selectedCountry!['flag']!,
                width: 28,
                height: 20,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 20, color: Colors.grey),
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _selectedCountry != null ? _selectedCountry!['name']! : 'Select a Country',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: null,
                  decoration: TextDecoration.none,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
          ],
        ),
      ),
    );
  }

  void _showCountryPickerDialog() {
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
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildMapSection() {
  //   final countryName = _selectedCountry != null ? _selectedCountry!['name']! : '';
  //   final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(countryName)}';
  //   final staticMapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=${Uri.encodeComponent(countryName)}&zoom=5&size=600x300&key=YOUR_API_KEY'; // Replace with your Google Maps Static API key
  //   return Container(
  //     width: double.infinity,
  //     height: 200.h,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15.r),
  //       border: Border.all(color: const Color(0xFF3498DB), width: 2),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(13.r),
  //       child: Stack(
  //         children: [
  //           // Show static map image for the selected country
  //           Image.network(
  //             staticMapUrl,
  //             width: double.infinity,
  //             height: double.infinity,
  //             fit: BoxFit.cover,
  //             errorBuilder: (context, error, stackTrace) => Container(
  //               color: Colors.grey[200],
  //               child: Center(child: Icon(Icons.map, color: Colors.grey, size: 40.sp)),
  //             ),
  //           ),
  //           Center(
  //             child: Icon(
  //               Icons.location_on,
  //               color: const Color(0xFFE74C3C),
  //               size: 40.sp,
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 16.h,
  //             left: 16.w,
  //             right: 16.w,
  //             child: GestureDetector(
  //               onTap: () async {
  //                 await Helpers.launchURL(googleMapsUrl);
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(vertical: 12.h),
  //                 decoration: BoxDecoration(
  //                   color: Colors.black.withOpacity(0.7),
  //                   borderRadius: BorderRadius.circular(20.r),
  //                 ),
  //                 child: Text(
  //                   'See Location in Google Maps',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMapSection() {
  final countryName = _selectedCountry != null ? _selectedCountry!['name']! : '';
  final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(countryName)}';
  final staticMapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=${Uri.encodeComponent(countryName)}&zoom=5&size=600x300&key=YOUR_API_KEY'; // Replace with your Google Maps Static API key

  return Container(
    width: double.infinity,
    height: 180.h, // Adjusted to match screenshot proportions
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: Color(0xFF3498DB), width: 3),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Map image with margin and rounded corners
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/backgrounds/map_logo.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        // Button at the bottom center
        Positioned(
          left: 0,
          right: 0,
          bottom: 12.h,
          child: Center(
            child: GestureDetector(
              onTap: () async {
                await Helpers.launchURL(googleMapsUrl);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'See Location in Google Maps',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: null,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
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
