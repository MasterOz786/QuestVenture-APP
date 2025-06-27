import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../../data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  Future<bool> signIn(String phoneNumber) async {
    _setLoading(true);
    _setError(null);
    
    try {
      final success = await _authService.signIn(phoneNumber);
      if (success) {
        _setError(null);
      } else {
        _setError('Failed to send OTP');
      }
      return success;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    _setLoading(true);
    _setError(null);
    
    try {
      final user = await _authService.verifyOtp(phoneNumber, otp);
      if (user != null) {
        _user = user;
        _setError(null);
        return true;
      } else {
        _setError('Invalid OTP');
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> signOut() async {
    _user = null;
    await _authService.signOut();
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
