import '../models/user_model.dart';
import '../../core/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<bool> signIn(String phoneNumber) async {
    try {
      return await _authService.signIn(phoneNumber);
    } catch (e) {
      throw Exception('Authentication failed: $e');
    }
  }

  Future<UserModel?> verifyOtp(String phoneNumber, String otp) async {
    try {
      return await _authService.verifyOtp(phoneNumber, otp);
    } catch (e) {
      throw Exception('OTP verification failed: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }
}
