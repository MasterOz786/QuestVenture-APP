// import 'package:flutter/material.dart';

// class GradientBackground extends StatelessWidget {
//   final Widget child;
//   const GradientBackground({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Image.asset(
//             'assets/images/backgrounds/background.jpeg',
//             fit: BoxFit.cover,
//           ),
//         ),
//         child,
//       ],
//     );
//   }
// } 


import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool useGradientOverlay;
  final bool centerImage;

  const GradientBackground({
    Key? key, 
    required this.child,
    this.useGradientOverlay = true,
    this.centerImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;
    
    return Stack(
      children: [
        // Background image with proper mobile adaptation
        Positioned.fill(
          child: Container(
            child: Stack(
              children: [
                // Main background image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/backgrounds/background.jpeg',
                    fit: _getOptimalBoxFit(screenSize, isPortrait),
                    alignment: _getOptimalAlignment(isPortrait),
                  ),
                ),
                
                // Optional gradient overlay for better text readability
                if (useGradientOverlay)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // Foreground content
        child,
      ],
    );
  }

  BoxFit _getOptimalBoxFit(Size screenSize, bool isPortrait) {
    // For mobile portrait mode, we want to show more of the vertical content
    if (isPortrait) {
      // Use fitWidth to ensure the full width is covered
      // and allow vertical scrolling/cropping
      return BoxFit.cover;
    } else {
      // For landscape or wider screens, use cover to fill the space
      return BoxFit.cover;
    }
  }

  Alignment _getOptimalAlignment(bool isPortrait) {
    if (centerImage) {
      return Alignment.center;
    }
    
    // For portrait mobile screens, align to show the important bottom elements
    // (people, animals, buildings) while keeping the sky gradient visible
    if (isPortrait) {
      return Alignment.bottomCenter;
    } else {
      // For landscape, center the image
      return Alignment.center;
    }
  }
}

// Alternative version with more control for specific screens
class AdaptiveGradientBackground extends StatelessWidget {
  final Widget child;
  final BackgroundStyle style;

  const AdaptiveGradientBackground({
    Key? key,
    required this.child,
    this.style = BackgroundStyle.auto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final aspectRatio = screenSize.width / screenSize.height;
    
    return Stack(
      children: [
        Positioned.fill(
          child: _buildBackgroundForStyle(context, style, aspectRatio),
        ),
        child,
      ],
    );
  }

  Widget _buildBackgroundForStyle(BuildContext context, BackgroundStyle style, double aspectRatio) {
    switch (style) {
      case BackgroundStyle.fullCover:
        return Image.asset(
          'assets/images/backgrounds/background.jpeg',
          fit: BoxFit.cover,
          alignment: Alignment.center,
        );
        
      case BackgroundStyle.mobileOptimized:
        return Container(
          child: Stack(
            children: [
              // Background with mobile-specific positioning
              Positioned.fill(
                child: Image.asset(
                  'assets/images/backgrounds/background.jpeg',
                  fit: BoxFit.cover,
                  alignment: aspectRatio < 0.7 ? Alignment.bottomCenter : Alignment.center,
                ),
              ),
              // Subtle gradient overlay for mobile readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.red.withOpacity(0.1),
                        Colors.transparent,
                        Colors.blue.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        
      case BackgroundStyle.gradientOnly:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE74C3C), // Red
                Color(0xFF3498DB), // Blue
              ],
            ),
          ),
        );
        
      case BackgroundStyle.auto:
      default:
        // Auto-detect best style based on screen ratio
        if (aspectRatio < 0.6) {
          // Very tall screens (like modern phones)
          return _buildBackgroundForStyle(context, BackgroundStyle.mobileOptimized, aspectRatio);
        } else if (aspectRatio > 1.5) {
          // Wide screens
          return _buildBackgroundForStyle(context, BackgroundStyle.fullCover, aspectRatio);
        } else {
          // Standard screens
          return _buildBackgroundForStyle(context, BackgroundStyle.mobileOptimized, aspectRatio);
        }
    }
  }
}

enum BackgroundStyle {
  auto,
  fullCover,
  mobileOptimized,
  gradientOnly,
}

// Utility widget for screens that need different background behavior
class ResponsiveGradientBackground extends StatelessWidget {
  final Widget child;
  final Widget? mobileBackground;
  final Widget? tabletBackground;
  final Widget? desktopBackground;

  const ResponsiveGradientBackground({
    Key? key,
    required this.child,
    this.mobileBackground,
    this.tabletBackground,
    this.desktopBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile
          return Stack(
            children: [
              Positioned.fill(
                child: mobileBackground ?? _buildMobileBackground(),
              ),
              child,
            ],
          );
        } else if (constraints.maxWidth < 1200) {
          // Tablet
          return Stack(
            children: [
              Positioned.fill(
                child: tabletBackground ?? _buildTabletBackground(),
              ),
              child,
            ],
          );
        } else {
          // Desktop
          return Stack(
            children: [
              Positioned.fill(
                child: desktopBackground ?? _buildDesktopBackground(),
              ),
              child,
            ],
          );
        }
      },
    );
  }

  Widget _buildMobileBackground() {
    return Image.asset(
      'assets/images/backgrounds/background.jpeg',
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter, // Show the people and elements at bottom
    );
  }

  Widget _buildTabletBackground() {
    return Image.asset(
      'assets/images/backgrounds/background.jpeg',
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  Widget _buildDesktopBackground() {
    return Image.asset(
      'assets/images/backgrounds/background.jpeg',
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }
}
