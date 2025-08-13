import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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
    Locale('zh')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flutter Flexible'**
  String get appTitle;

  /// A greeting message
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flutter Flexible'**
  String get welcome;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Home tab title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// My personal tab title
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myPersonal;

  /// User information button text
  ///
  /// In en, this message translates to:
  /// **'User Info'**
  String get userInfo;

  /// Global theme switch title
  ///
  /// In en, this message translates to:
  /// **'Theme Switch'**
  String get themeSwitch;

  /// Light blue theme option
  ///
  /// In en, this message translates to:
  /// **'Light Blue Theme'**
  String get lightBlueTheme;

  /// Dark mode theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Gray mode enabled status
  ///
  /// In en, this message translates to:
  /// **'Gray Mode - ON'**
  String get grayModeOn;

  /// Gray mode disabled status
  ///
  /// In en, this message translates to:
  /// **'Gray Mode - OFF'**
  String get grayModeOff;

  /// Error page title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPageTitle;

  /// Undefined route error message
  ///
  /// In en, this message translates to:
  /// **'Error: Undefined route'**
  String get undefinedRoute;

  /// Ad page countdown message
  ///
  /// In en, this message translates to:
  /// **'Ad page, jump to main page in {seconds} seconds'**
  String adPageCountdown(int seconds);

  /// Skip button text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Welcome guide page text
  ///
  /// In en, this message translates to:
  /// **'Guide Page~'**
  String get guidePage;

  /// State management value display
  ///
  /// In en, this message translates to:
  /// **'State Management Value: {value}'**
  String stateManagementValue(int value);

  /// Increment button text
  ///
  /// In en, this message translates to:
  /// **'Add +'**
  String get increment;

  /// Decrement button text
  ///
  /// In en, this message translates to:
  /// **'Subtract -'**
  String get decrement;

  /// Current language display
  ///
  /// In en, this message translates to:
  /// **'Current Language: {language}'**
  String currentLanguage(String language);

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings Page'**
  String get settingsPage;

  /// Settings page content description
  ///
  /// In en, this message translates to:
  /// **'This is the settings page content'**
  String get settingsContent;

  /// App settings description
  ///
  /// In en, this message translates to:
  /// **'App settings and preferences'**
  String get appSettings;

  /// General settings section title
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// Language settings title
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Language settings description
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get languageSettingsDesc;

  /// Notification settings title
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// Notification settings description
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get notificationSettingsDesc;

  /// Privacy settings title
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySettings;

  /// Privacy settings description
  ///
  /// In en, this message translates to:
  /// **'Privacy settings and security options'**
  String get privacySettingsDesc;

  /// Appearance settings section title
  ///
  /// In en, this message translates to:
  /// **'Appearance Settings'**
  String get appearanceSettings;

  /// Theme settings title
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// Theme settings description
  ///
  /// In en, this message translates to:
  /// **'Choose app theme'**
  String get themeSettingsDesc;

  /// Font settings title
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSettings;

  /// Font settings description
  ///
  /// In en, this message translates to:
  /// **'Adjust text display size'**
  String get fontSettingsDesc;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// About app title
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// About app description
  ///
  /// In en, this message translates to:
  /// **'Version info and developer information'**
  String get aboutAppDesc;

  /// Help and feedback title
  ///
  /// In en, this message translates to:
  /// **'Help & Feedback'**
  String get helpFeedback;

  /// Help and feedback description
  ///
  /// In en, this message translates to:
  /// **'Get help or provide feedback'**
  String get helpFeedbackDesc;

  /// Feature in development message
  ///
  /// In en, this message translates to:
  /// **'Feature in development'**
  String get featureInDevelopment;

  /// Notification feature development message
  ///
  /// In en, this message translates to:
  /// **'Notification settings feature in development'**
  String get notificationFeatureInDev;

  /// Privacy feature development message
  ///
  /// In en, this message translates to:
  /// **'Privacy settings feature in development'**
  String get privacyFeatureInDev;

  /// Theme feature development message
  ///
  /// In en, this message translates to:
  /// **'Theme settings feature in development'**
  String get themeFeatureInDev;

  /// Font feature development message
  ///
  /// In en, this message translates to:
  /// **'Font settings feature in development'**
  String get fontFeatureInDev;

  /// Help feature development message
  ///
  /// In en, this message translates to:
  /// **'Help feature in development'**
  String get helpFeatureInDev;

  /// About app description text
  ///
  /// In en, this message translates to:
  /// **'This is a flexible application framework based on Flutter, providing rich features and excellent user experience.'**
  String get aboutAppDescription;

  /// Select theme title
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// Light mode theme option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Light mode description
  ///
  /// In en, this message translates to:
  /// **'Bright and clean interface'**
  String get lightModeDesc;

  /// Dark mode description
  ///
  /// In en, this message translates to:
  /// **'Dark interface, easy on the eyes'**
  String get darkModeDesc;

  /// Blue mode theme option
  ///
  /// In en, this message translates to:
  /// **'Blue Mode'**
  String get blueMode;

  /// Blue mode description
  ///
  /// In en, this message translates to:
  /// **'Professional blue theme'**
  String get blueModeDesc;

  /// Theme preview section title
  ///
  /// In en, this message translates to:
  /// **'Theme Preview'**
  String get themePreview;

  /// Preview card title
  ///
  /// In en, this message translates to:
  /// **'Preview Title'**
  String get previewTitle;

  /// Preview card subtitle
  ///
  /// In en, this message translates to:
  /// **'This is how the theme looks'**
  String get previewSubtitle;

  /// Primary button text
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primaryButton;

  /// Secondary button text
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get secondaryButton;

  /// Email client error message
  ///
  /// In en, this message translates to:
  /// **'Unable to open email client, please send email manually to support@jonlantech.com'**
  String get emailClientError;

  /// Email subject for support
  ///
  /// In en, this message translates to:
  /// **'Flutter Flexible Support'**
  String get emailSupportSubject;

  /// Privacy policy title
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of service title
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Terms of purchase title
  ///
  /// In en, this message translates to:
  /// **'Terms of Purchase'**
  String get termsOfPurchase;

  /// Privacy policy description
  ///
  /// In en, this message translates to:
  /// **'View our privacy policy'**
  String get privacyPolicyDesc;

  /// Terms of service description
  ///
  /// In en, this message translates to:
  /// **'View terms of service'**
  String get termsOfServiceDesc;

  /// Terms of purchase description
  ///
  /// In en, this message translates to:
  /// **'View purchase terms and conditions'**
  String get termsOfPurchaseDesc;
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
