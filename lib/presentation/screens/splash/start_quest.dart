// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'gradient_background.dart';
// import '../location/location_screen.dart';
// import 'leaderboard_screen.dart';
// import 'about_us_screen.dart';

// class StartQuestScreen extends StatelessWidget {
//   final String userName;
//   final String countryFlagUrl;
//   final String languageName;

//   const StartQuestScreen({
//     Key? key,
//     required this.userName,
//     required this.countryFlagUrl,
//     required this.languageName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GradientBackground(
//         child: Stack(
//           children: [
//             // Main content
//             Column(
//               children: [
//                 SizedBox(height: 60.h), // Status bar space
                
//                 // Header with black logo
//                 Image.asset(
//                   'assets/images/backgrounds/black_logo.png',
//                   width: 350.w,
//                   fit: BoxFit.contain,
//                 ),
                
//                 SizedBox(height: 40.h),
                
//                 // Main white container
//                 Expanded(
//                   child: Container(
//                     width: 350.w,
//                     margin: EdgeInsets.symmetric(horizontal: 20.w),
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.85),
//                       borderRadius: BorderRadius.circular(32.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Welcome text
//                         Text(
//                           'WELCOME BACK ${userName.toUpperCase()}!',
//                           style: TextStyle(
//                             color: const Color(0xFF3498DB),
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1.0,
//                             fontFamily: 'Beachday',
//                           ),
//                         ),
                        
//                         SizedBox(height: 12.h),
                        
//                         // Language selector
//                         Row(
//                           children: [
//                             Image.network(
//                               countryFlagUrl, 
//                               width: 32, 
//                               height: 24, 
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   width: 32,
//                                   height: 24,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.flag, size: 16),
//                                 );
//                               },
//                             ),
//                             SizedBox(width: 8.w),
//                             Expanded(
//                               child: Text(
//                                 languageName,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: '',
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
//                           ],
//                         ),
                        
//                         SizedBox(height: 40.h),
                        
//                         // START QUEST button
//                         _buildMenuButton(
//                           context,
//                           color: const Color(0xFFE74C3C),
//                           text: 'START QUEST',
//                           iconAsset: 'assets/images/backgrounds/start_quest.png',
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => LocationScreen()),
//                             );
//                           },
//                           textStyle: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Beachday',
//                             letterSpacing: 1.0,
//                           ),
//                         ),
                        
//                         SizedBox(height: 20.h),
                        
//                         // LEADER BOARD button
//                         _buildMenuButton(
//                           context,
//                           color: Colors.white,
//                           text: 'LEADER BOARD',
//                           iconAsset: 'assets/images/backgrounds/leader_board.png',
//                           borderColor: const Color(0xFF3498DB),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
//                             );
//                           },
//                           textStyle: TextStyle(
//                             color: const Color(0xFF3498DB),
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Beachday',
//                             letterSpacing: 1.0,
//                           ),
//                         ),
                        
//                         SizedBox(height: 20.h),
                        
//                         // ABOUT US button
//                         _buildMenuButton(
//                           context,
//                           color: Colors.white,
//                           text: 'ABOUT US',
//                           iconAsset: 'assets/images/backgrounds/about_us.png',
//                           borderColor: const Color(0xFF3498DB),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const AboutScreen()),
//                             );
//                           },
//                           textStyle: TextStyle(
//                             color: const Color(0xFF3498DB),
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Beachday',
//                             letterSpacing: 1.0,
//                           ),
//                         ),
                        
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 SizedBox(height: 120.h), // Space for background and powered by text
//               ],
//             ),
            
//             // Powered by text
//             Positioned(
//               bottom: 32.h,
//               right: 20.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Powered By',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: '',
//                     ),
//                   ),
//                   Text(
//                     'Velitt',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: '',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuButton(
//     BuildContext context, {
//     required Color color,
//     required String text,
//     String? iconAsset,
//     Color borderColor = Colors.transparent,
//     required VoidCallback onTap,
//     required TextStyle textStyle,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: 45.h,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(32.r),
//         border: Border.all(color: borderColor, width: 3),
//         boxShadow: [
//           if (color != Colors.white)
//             BoxShadow(
//               color: color.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(32.r),
//           onTap: onTap,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (iconAsset != null) ...[
//                 Image.asset(
//                   iconAsset, 
//                   width: 28, 
//                   height: 28,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(
//                       Icons.image_not_supported,
//                       size: 28,
//                       color: textStyle.color,
//                     );
//                   },
//                 ),
//                 SizedBox(width: 12.w),
//               ],
//               Text(
//                 text,
//                 style: textStyle,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gradient_background.dart';
import '../location/location_screen.dart';
import 'leaderboard_screen.dart';
import 'about_us_screen.dart';
import '../../../core/theme/app_colors.dart';

class StartQuestScreen extends StatelessWidget {
  final String userName;
  final String countryFlagUrl;
  final String languageName;
  final Map<String, String> selectedCountry;

  const StartQuestScreen({
    Key? key,
    required this.userName,
    required this.countryFlagUrl,
    required this.languageName,
    required this.selectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayName = userName.contains('@') ? userName.split('@')[0] : userName;
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    // Header with black logo
                    Image.asset(
                      'assets/images/backgrounds/black_logo.png',
                      width: 350.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 40.h),
                    // Main white card (no fixed height)
                    Container(
                      width: 350.w,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome text
                          Text(
                            'WELCOME BACK ${displayName.toUpperCase()}!',
                            style: TextStyle(
                              color: const Color(0xFF3498DB),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: 'Beachday',
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Language selector
                          Row(
                            children: [
                              Image.network(
                                countryFlagUrl, 
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
                                  languageName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: '',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3498DB)),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          // START QUEST button
                          _buildMenuButton(
                            context,
                            color: const Color(0xFFE74C3C),
                            text: 'START QUEST',
                            iconAsset: 'assets/images/backgrounds/start_quest.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LocationScreen(selectedCountry: selectedCountry)),
                              );
                            },
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Beachday',
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // LEADER BOARD button
                          _buildMenuButton(
                            context,
                            color: Colors.white,
                            text: 'LEADER BOARD',
                            iconAsset: 'assets/images/backgrounds/leader_board.png',
                            borderColor: const Color(0xFF3498DB),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                              );
                            },
                            textStyle: TextStyle(
                              color: const Color(0xFF3498DB),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Beachday',
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // ABOUT US button
                          _buildMenuButton(
                            context,
                            color: Colors.white,
                            text: 'ABOUT US',
                            iconAsset: 'assets/images/backgrounds/about_us.png',
                            borderColor: const Color(0xFF3498DB),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AboutScreen()),
                              );
                            },
                            textStyle: TextStyle(
                              color: const Color(0xFF3498DB),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Beachday',
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 120.h), // Space for background and powered by text
                  ],
                ),
              ),
            ),
            // Powered by text pinned to bottom right
            Positioned(
              bottom: 32.h,
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

  Widget _buildMenuButton(
    BuildContext context, {
    required Color color,
    required String text,
    required String iconAsset,
    Color borderColor = Colors.transparent,
    required VoidCallback onTap,
    required TextStyle textStyle,
  }) {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          if (color != Colors.white)
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32.r),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                width: 28,
                height: 28,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 28,
                    color: textStyle.color,
                  );
                },
              ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


