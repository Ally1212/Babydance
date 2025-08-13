// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Flexible';

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome to Flutter Flexible';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get home => 'Home';

  @override
  String get myPersonal => 'My Profile';

  @override
  String get userInfo => 'User Info';

  @override
  String get themeSwitch => 'Theme Switch';

  @override
  String get lightBlueTheme => 'Light Blue Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get grayModeOn => 'Gray Mode - ON';

  @override
  String get grayModeOff => 'Gray Mode - OFF';

  @override
  String get errorPageTitle => 'Error';

  @override
  String get undefinedRoute => 'Error: Undefined route';

  @override
  String adPageCountdown(int seconds) {
    return 'Ad page, jump to main page in $seconds seconds';
  }

  @override
  String get skip => 'Skip';

  @override
  String get guidePage => 'Guide Page~';

  @override
  String stateManagementValue(int value) {
    return 'State Management Value: $value';
  }

  @override
  String get increment => 'Add +';

  @override
  String get decrement => 'Subtract -';

  @override
  String currentLanguage(String language) {
    return 'Current Language: $language';
  }

  @override
  String get settingsPage => 'Settings Page';

  @override
  String get settingsContent => 'This is the settings page content';

  @override
  String get appSettings => 'App settings and preferences';

  @override
  String get generalSettings => 'General Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get languageSettingsDesc => 'Choose app language';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get notificationSettingsDesc => 'Manage notification preferences';

  @override
  String get privacySettings => 'Privacy & Security';

  @override
  String get privacySettingsDesc => 'Privacy settings and security options';

  @override
  String get appearanceSettings => 'Appearance Settings';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get themeSettingsDesc => 'Choose app theme';

  @override
  String get fontSettings => 'Font Size';

  @override
  String get fontSettingsDesc => 'Adjust text display size';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutApp => 'About App';

  @override
  String get aboutAppDesc => 'Version info and developer information';

  @override
  String get helpFeedback => 'Help & Feedback';

  @override
  String get helpFeedbackDesc => 'Get help or provide feedback';

  @override
  String get featureInDevelopment => 'Feature in development';

  @override
  String get notificationFeatureInDev =>
      'Notification settings feature in development';

  @override
  String get privacyFeatureInDev => 'Privacy settings feature in development';

  @override
  String get themeFeatureInDev => 'Theme settings feature in development';

  @override
  String get fontFeatureInDev => 'Font settings feature in development';

  @override
  String get helpFeatureInDev => 'Help feature in development';

  @override
  String get aboutAppDescription =>
      'This is a flexible application framework based on Flutter, providing rich features and excellent user experience.';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get lightModeDesc => 'Bright and clean interface';

  @override
  String get darkModeDesc => 'Dark interface, easy on the eyes';

  @override
  String get blueMode => 'Blue Mode';

  @override
  String get blueModeDesc => 'Professional blue theme';

  @override
  String get themePreview => 'Theme Preview';

  @override
  String get previewTitle => 'Preview Title';

  @override
  String get previewSubtitle => 'This is how the theme looks';

  @override
  String get primaryButton => 'Primary';

  @override
  String get secondaryButton => 'Secondary';
}
