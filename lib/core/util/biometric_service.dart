import 'package:flutter/foundation.dart' show kIsWeb; // 👈 ایمپورت برای تشخیص پلتفرم وب
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isBiometricAvailable() async {
    // ۱. اگر روی وب/اکستنشن کروم هستیم، بیومتریک قطعا در دسترس نیست
    if (kIsWeb) {
      return false; 
    }

    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool isDeviceSupported = await _auth.isDeviceSupported();
      return canAuthenticateWithBiometrics && isDeviceSupported;
    } catch (e) {
      // استفاده از try-catch برای جلوگیری از کرش کردن در پلتفرم‌های ناشناخته
      return false;
    }
  }

  static Future<bool> authenticate() async {
    // ۲. مدیریت ورود در اکستنشن کروم
    if (kIsWeb) {
      // در حال حاضر برای اینکه اکستنشن بالا بیاید و متوقف نشود، مستقیماً true برمی‌گردانیم.
      // 💡 در آینده می‌توانید اینجا را تغییر دهید تا از کاربر یک PIN 코드 ٤ رقمی بخواهد.
      return true; 
    }

    try {
      final available = await isBiometricAvailable();
      
      // طبق منطق قبلی خودتان: اگر سنسور نبود، اجازه ورود می‌دهیم
      if (!available) return true;

      // اجرای بیومتریک فقط برای اندروید و iOS
      return await _auth.authenticate(
        localizedReason: 'use your fingerprint or screen lock to continue',
        // سینتکس بر اساس نسخه پکیج شما حفظ شد
        // اگر پکیج local_auth را آپدیت کردید، این بخش به AuthenticationOptions تغییر می‌کند
        biometricOnly: false,
        persistAcrossBackgrounding: true, // (بسته به نسخه پکیج شما)
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}