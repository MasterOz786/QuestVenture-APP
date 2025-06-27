import 'package:flutter/foundation.dart';
import '../services/location_service.dart';

class LocationProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();
  
  String _selectedLanguage = 'English UK';
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentLocation;
  
  String get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentLocation => _currentLocation;
  
  final List<Map<String, String>> _languages = [
    {'name': 'English UK', 'code': 'en_UK', 'flag': '🇬🇧'},
    {'name': 'English US', 'code': 'en_US', 'flag': '🇺🇸'},
    {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸'},
    {'name': 'French', 'code': 'fr', 'flag': '🇫🇷'},
  ];
  
  List<Map<String, String>> get languages => _languages;
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
  
  Future<void> getCurrentLocation() async {
    _setLoading(true);
    _setError(null);
    
    try {
      _currentLocation = await _locationService.getCurrentLocation();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> confirmLocation() async {
    _setLoading(true);
    _setError(null);
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
