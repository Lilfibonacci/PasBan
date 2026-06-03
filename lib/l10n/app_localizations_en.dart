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
      'No accounts added yet.\nTap the fab button to scan a QR code.';

  @override
  String get addAcount => 'add account';

  @override
  String get addAcountSuccessMessage => 'Account Saved !';

  @override
  String get addAcountFailureMessage => 'Invalid QR Code!';
}
