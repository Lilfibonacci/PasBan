import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'PasBan'**
  String get title;

  /// No description provided for @button.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get button;

  /// No description provided for @darkModeTle.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeTle;

  /// No description provided for @workTile.
  ///
  /// In en, this message translates to:
  /// **'How Its Work'**
  String get workTile;

  /// No description provided for @aboutUsTile.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsTile;

  /// No description provided for @laguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get laguage;

  /// No description provided for @sourceTile.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceTile;

  /// No description provided for @emailTile.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTile;

  /// No description provided for @telegramTile.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegramTile;

  /// No description provided for @describtion.
  ///
  /// In en, this message translates to:
  /// **'Your trusted, cross-platform companion for secure and effortless two-factor authentication.'**
  String get describtion;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scan;

  /// No description provided for @snackBar.
  ///
  /// In en, this message translates to:
  /// **'No barcodes were found in this image.'**
  String get snackBar;

  /// No description provided for @accountMessage.
  ///
  /// In en, this message translates to:
  /// **'No accounts added yet! \nTap the fab button to addAcount.'**
  String get accountMessage;

  /// No description provided for @addAcount.
  ///
  /// In en, this message translates to:
  /// **'add account'**
  String get addAcount;

  /// No description provided for @addAcountSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Account Saved !'**
  String get addAcountSuccessMessage;

  /// No description provided for @addAcountFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR Code!'**
  String get addAcountFailureMessage;

  /// No description provided for @buttomSheetScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan a QR Code'**
  String get buttomSheetScanTitle;

  /// No description provided for @buttomSheetScanSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Use camera to scan code from another screen or scan from gallery'**
  String get buttomSheetScanSubTitle;

  /// No description provided for @buttomSheetSetupKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Setup Key'**
  String get buttomSheetSetupKeyTitle;

  /// No description provided for @buttomSheetSetupKeySubTitle.
  ///
  /// In en, this message translates to:
  /// **'Manually type your account details'**
  String get buttomSheetSetupKeySubTitle;

  /// No description provided for @copyText.
  ///
  /// In en, this message translates to:
  /// **'Code copied to clipboard!'**
  String get copyText;

  /// No description provided for @dialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get dialogTitle;

  /// No description provided for @dialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove your account? You will lose access to its 2FA codes permanently.'**
  String get dialogContent;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @deleteSnackBar.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully deleted'**
  String get deleteSnackBar;

  /// No description provided for @unlockAppbutton.
  ///
  /// In en, this message translates to:
  /// **'Unlock App'**
  String get unlockAppbutton;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @obSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'High-Level Security'**
  String get obSecurityTitle;

  /// No description provided for @obSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'All your secret keys are hardware-backed and strictly encrypted, staying safely on your own device.'**
  String get obSecurityDesc;

  /// No description provided for @obOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'100% Offline by Design'**
  String get obOfflineTitle;

  /// No description provided for @obOfflineDesc.
  ///
  /// In en, this message translates to:
  /// **'PasBan requires zero network permissions. Your security keys will never touch cloud databases.'**
  String get obOfflineDesc;

  /// No description provided for @obBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Biometric Lock'**
  String get obBiometricTitle;

  /// No description provided for @obBiometricDesc.
  ///
  /// In en, this message translates to:
  /// **'Protect your authentication codes from unauthorized access using device-native Fingerprint or Face ID.'**
  String get obBiometricDesc;

  /// No description provided for @webScanTitle.
  ///
  /// In en, this message translates to:
  /// **'scan with image'**
  String get webScanTitle;

  /// No description provided for @webScanSubTitle.
  ///
  /// In en, this message translates to:
  /// **'upload screenShot from QR Code here!'**
  String get webScanSubTitle;

  /// No description provided for @webScanTitleButton.
  ///
  /// In en, this message translates to:
  /// **'choose image from system'**
  String get webScanTitleButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
