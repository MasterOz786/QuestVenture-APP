# Beachday Font Setup Instructions

## Overview
The application has been configured to use the Beachday font family throughout the entire app. To complete the setup, you need to add the Beachday font files to your project.

## Required Font Files
You need to add the following Beachday font files to the `assets/fonts/` directory:

1. `Beachday-Regular.ttf` - Regular weight font
2. `Beachday-Bold.ttf` - Bold weight font (700)
3. `Beachday-Medium.ttf` - Medium weight font (500)

## Steps to Complete Setup

1. **Obtain the Beachday font files** from your font provider or designer
2. **Place the font files** in the `assets/fonts/` directory:
   ```
   assets/fonts/
   ├── Beachday-Regular.ttf
   ├── Beachday-Bold.ttf
   ├── Beachday-Medium.ttf
   ├── Roboto-Regular.ttf
   ├── Roboto-Bold.ttf
   └── Roboto-Medium.ttf
   ```

3. **Run flutter pub get** to update the font configuration:
   ```bash
   flutter pub get
   ```

4. **Clean and rebuild** the project:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## What Has Been Updated

The following files have been modified to use Beachday as the default font:

- `pubspec.yaml` - Added Beachday font configuration
- `lib/core/theme/app_theme.dart` - Set Beachday as default font family
- All screen files - Updated fontFamily references from 'LuckiestGuy' to 'Beachday'

## Font Usage

The Beachday font will now be used throughout the application:
- As the default font family in the app theme
- For all text elements that previously used 'LuckiestGuy'
- Roboto remains as a fallback font

## Troubleshooting

If you see font-related errors after adding the files:
1. Ensure the font file names match exactly (case-sensitive)
2. Run `flutter clean` and `flutter pub get`
3. Restart your development environment
4. Check that the font files are valid TTF files 