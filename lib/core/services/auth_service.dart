import '../../data/models/user_model.dart';
import 'email_service.dart';
import 'storage_service.dart';

class AuthService {
  final EmailService _emailService = EmailService();
  final StorageService _storageService = StorageService();

  Future<bool> signIn(String email) async {
    try {
      print('Attempting to send OTP to: $email');

      // Validate email format
      if (!_isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      // Clean up expired OTPs first
      _emailService.cleanupExpiredOtps();

      // Send OTP via email
      final success = await _emailService.sendOtp(email);

      if (success) {
        print('✅ OTP process initiated for $email');

        // For debugging - get the generated OTP
        final storedOtp = _emailService.getStoredOtp(email);
        print('🔑 Generated OTP: $storedOtp (use this for testing)');

        return true;
      } else {
        throw Exception('Failed to send OTP email');
      }
    } catch (e) {
      print('❌ Error in signIn: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<UserModel?> verifyOtp(String email, String otp) async {
    try {
      print('Attempting to verify OTP for: $email with OTP: $otp');

      // Verify OTP with email service
      final isValid = _emailService.verifyOtp(email, otp);

      if (isValid) {
        print('✅ OTP verified successfully for $email');

        final user = UserModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          phoneNumber: email, // Using email as identifier
          name: 'Quest User',
          isVerified: true,
        );

        await _storageService.storeUser(user);
        return user;
      } else {
        print('❌ OTP verification failed for $email');
        return null;
      }
    } catch (e) {
      print('❌ Error in verifyOtp: $e');
      throw Exception('Failed to verify OTP: $e');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _storageService.getUser();
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _storageService.clearUser();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}
