class LocationService {
  Future<String> getCurrentLocation() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return 'Chicago, IL, USA';
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }
  
  Future<bool> requestLocationPermission() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      throw Exception('Failed to request location permission: $e');
    }
  }
}
