// import 'package:flutter/material.dart';
// //import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppBackground extends StatelessWidget {
//   final Widget child;
//   const AppBackground({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Use the provided background image for the whole app
//         Positioned.fill(
//           child: Image.asset(
//           //  'assets/images/backgrounds/background.jpeg',
//             fit: BoxFit.cover,
//           ),
//         ),
//         // Main content with padding to avoid overlap with bottom collage in the image
//         SafeArea(
//           child: Padding(
//             padding: EdgeInsets.only(bottom: 32.h, left: 16.w, right: 16.w, top: 16.h),
//             child: child,
//           ),
//         ),
//       ],
//     );
//   }
// }
