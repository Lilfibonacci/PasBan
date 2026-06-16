// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'PasBan';

  @override
  String get button => 'Copy';

  @override
  String get darkModeTle => 'Dark Mode';

  @override
  String get workTile => 'How Its Work';

  @override
  String get aboutUsTile => 'About Us';

  @override
  String get laguage => 'Language';

  @override
  String get sourceTile => 'Source Code';

  @override
  String get emailTile => 'Email';

  @override
  String get telegramTile => 'Telegram';

  @override
  String get describtion =>
      'Your trusted, cross-platform companion for secure and effortless two-factor authentication.';

  @override
  String get scan => 'Scan QR';

  @override
  String get snackBar => 'No barcodes were found in this image.';

  @override
  String get accountMessage =>
      'No accounts added yet! \nTap the fab button to addAcount.';

  @override
  String get addAcount => 'add account';

  @override
  String get addAcountSuccessMessage => 'Account Saved !';

  @override
  String get addAcountFailureMessage => 'Invalid QR Code!';

  @override
  String get buttomSheetScanTitle => 'Scan a QR Code';

  @override
  String get buttomSheetScanSubTitle =>
      'Use camera to scan code from another screen or scan from gallery';

  @override
  String get buttomSheetSetupKeyTitle => 'Enter Setup Key';

  @override
  String get buttomSheetSetupKeySubTitle =>
      'Manually type your account details';

  @override
  String get copyText => 'Code copied to clipboard!';

  @override
  String get dialogTitle => 'Delete Account?';

  @override
  String get dialogContent =>
      'Are you sure you want to remove your account? You will lose access to its 2FA codes permanently.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteSnackBar => 'Your account has been successfully deleted';

  @override
  String get unlockAppbutton => 'Unlock App';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get obSecurityTitle => 'High-Level Security';

  @override
  String get obSecurityDesc =>
      'All your secret keys are hardware-backed and strictly encrypted, staying safely on your own device.';

  @override
  String get obOfflineTitle => '100% Offline by Design';

  @override
  String get obOfflineDesc =>
      'PasBan requires zero network permissions. Your security keys will never touch cloud databases.';

  @override
  String get obBiometricTitle => 'Smart Biometric Lock';

  @override
  String get obBiometricDesc =>
      'Protect your authentication codes from unauthorized access using device-native Fingerprint or Face ID.';

  @override
  String get webScanTitle => 'scan with image';

  @override
  String get webScanSubTitle => 'upload screenShot from QR Code here!';

  @override
  String get webScanTitleButton => 'choose image from system';
}
