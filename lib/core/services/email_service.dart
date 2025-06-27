import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class EmailService {
  // Store OTPs temporarily (in production, use a proper database)
  static final Map<String, Map<String, dynamic>> _otpStorage = {};

  // Using EmailJS as a more reliable alternative to direct SMTP
  static const String _emailJSServiceId = 'YOUR_EMAILJS_SERVICE_ID';
  static const String _emailJSTemplateId = 'YOUR_EMAILJS_TEMPLATE_ID';
  static const String _emailJSUserId = 'YOUR_EMAILJS_USER_ID';

  Future<bool> sendOtp(String email) async {
    try {
      // Generate 5-digit OTP
      final otp = _generateOtp();

      // Store OTP with expiration (10 minutes) and more attempts for development
      _otpStorage[email] = {
        'otp': otp,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'attempts': 0,
      };

      print('Generated OTP for $email: $otp'); // For debugging - remove in production

      // Try multiple methods to send email
      bool success = false;

      // Method 1: Try EmailJS (recommended for Flutter apps)
      try {
        success = await _sendViaEmailJS(email, otp);
        if (success) {
          print('Email sent successfully via EmailJS');
          return true;
        }
      } catch (e) {
        print('EmailJS failed: $e');
      }

      // Method 2: Try a simple HTTP email service
      try {
        success = await _sendViaHttpService(email, otp);
        if (success) {
          print('Email sent successfully via HTTP service');
          return true;
        }
      } catch (e) {
        print('HTTP service failed: $e');
      }

      // Method 3: For development - just return true and log the OTP
      print('⚠️ DEVELOPMENT MODE: Email sending failed, but OTP is: $otp');
      print('⚠️ Use this OTP for testing: $otp');
      return true; // Return true for development

    } catch (e) {
      print('Error in sendOtp: $e');
      return false;
    }
  }

  Future<bool> _sendViaEmailJS(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': _emailJSServiceId,
          'template_id': _emailJSTemplateId,
          'user_id': _emailJSUserId,
          'template_params': {
            'to_email': email,
            'otp_code': otp,
            'app_name': 'Quest Venture',
          },
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('EmailJS error: $e');
      return false;
    }
  }

  Future<bool> _sendViaHttpService(String email, String otp) async {
    try {
      // Using a free email service API (replace with your preferred service)
      final response = await http.post(
        Uri.parse('https://formspree.io/f/YOUR_FORM_ID'), // Replace with your Formspree form ID
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'subject': 'Quest Venture - Your OTP Code',
          'message': 'Your OTP code is: $otp\n\nThis code will expire in 10 minutes.',
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('HTTP service error: $e');
      return false;
    }
  }

  bool verifyOtp(String email, String enteredOtp) {
    try {
      final storedData = _otpStorage[email];

      if (storedData == null) {
        print('No OTP found for email: $email');
        return false;
      }

      final storedOtp = storedData['otp'] as String;
      final timestamp = storedData['timestamp'] as int;
      final attempts = storedData['attempts'] as int;

      print('Verifying OTP for $email: entered=$enteredOtp, stored=$storedOtp, attempts=$attempts');

      // Check if OTP has expired (10 minutes for development)
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final otpAge = currentTime - timestamp;
      final tenMinutesInMs = 10 * 60 * 1000; // Increased to 10 minutes

      if (otpAge > tenMinutesInMs) {
        print('OTP expired for $email');
        _otpStorage.remove(email);
        return false;
      }

      // Increased attempt limit to 10 for development
      if (attempts >= 10) {
        print('Max attempts reached for $email');
        _otpStorage.remove(email);
        return false;
      }

      // Increment attempt count
      _otpStorage[email]!['attempts'] = attempts + 1;

      // Verify OTP
      if (storedOtp == enteredOtp) {
        print('✅ OTP verified successfully for $email');
        _otpStorage.remove(email);
        return true;
      }

      print('❌ OTP mismatch for $email (attempt ${attempts + 1}/10)');
      return false;
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  String _generateOtp() {
    final random = Random();
    return (10000 + random.nextInt(90000)).toString();
  }

  // Get the current OTP for debugging (remove in production)
  String? getStoredOtp(String email) {
    return _otpStorage[email]?['otp'];
  }

  // Get remaining attempts
  int getRemainingAttempts(String email) {
    final storedData = _otpStorage[email];
    if (storedData == null) return 0;
    final attempts = storedData['attempts'] as int;
    return 10 - attempts; // Max 10 attempts
  }

  // Reset OTP attempts (useful for development)
  void resetOtpAttempts(String email) {
    final storedData = _otpStorage[email];
    if (storedData != null) {
      _otpStorage[email]!['attempts'] = 0;
      print('🔄 Reset attempts for $email');
    }
  }

  // Clean up expired OTPs
  void cleanupExpiredOtps() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final tenMinutesInMs = 10 * 60 * 1000;

    _otpStorage.removeWhere((email, data) {
      final timestamp = data['timestamp'] as int;
      return (currentTime - timestamp) > tenMinutesInMs;
    });
  }

  // Force remove OTP (for development)
  void clearOtp(String email) {
    _otpStorage.remove(email);
    print('🗑️ Cleared OTP for $email');
  }
}
