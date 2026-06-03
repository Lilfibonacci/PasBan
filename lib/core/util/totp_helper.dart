import 'package:otp/otp.dart';

class TotpHelper {
  static String generateCode(String secret) {
    try {
      final time = DateTime.now().millisecondsSinceEpoch;

      return OTP.generateTOTPCodeString(
        secret,
        time,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );
    } catch (e) {
      return "Error";
    }
  }
}
