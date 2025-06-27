class Validators {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }
    
    return null;
  }
  
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    
    // Fixed: Now validates 5 digits instead of 4
    if (value.length != 5) {
      return 'OTP must be 5 digits';
    }
    
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }
    
    return null;
  }
  
  static String? validateAnswer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Answer is required';
    }
    
    if (value.trim().length < 2) {
      return 'Answer is too short';
    }
    
    return null;
  }
  
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  static bool isValidUrl(String url) {
    return Uri.tryParse(url) != null;
  }
}
