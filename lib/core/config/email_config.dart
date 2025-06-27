class EmailConfig {
  // Gmail SMTP Configuration
  static const String smtpHost = 'smtp.gmail.com';
  static const int smtpPort = 587;
  
  // TODO: Replace these with your actual email credentials
  static const String senderEmail = 'your-quest-venture-app@gmail.com';
  static const String senderPassword = 'your-app-specific-password';
  static const String senderName = 'Quest Venture';
  
  // OTP Configuration
  static const int otpLength = 5;
  static const int otpExpiryMinutes = 5;
  static const int maxOtpAttempts = 3;
  
  // Email Template Configuration
  static const String appName = 'Quest Venture';
  static const String companyName = 'Velitt';
  
  // Alternative SMTP Providers (uncomment to use)
  
  // Outlook/Hotmail
  // static const String smtpHost = 'smtp-mail.outlook.com';
  // static const int smtpPort = 587;
  
  // Yahoo
  // static const String smtpHost = 'smtp.mail.yahoo.com';
  // static const int smtpPort = 587;
  
  // Custom SMTP (replace with your provider)
  // static const String smtpHost = 'mail.yourdomain.com';
  // static const int smtpPort = 587;
}
