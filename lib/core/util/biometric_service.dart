import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool isDeviceSupported = await _auth.isDeviceSupported();
    return canAuthenticateWithBiometrics && isDeviceSupported;
  }

  static Future<bool> authenticate() async {
    try {
      final available = await isBiometricAvailable();
      if (!available) return true;

      return await _auth.authenticate(
        localizedReason: 'use your fingerprint or screen lock to continue',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}
