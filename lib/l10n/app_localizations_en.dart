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
}
