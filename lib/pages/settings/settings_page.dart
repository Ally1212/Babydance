import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';
import 'language_settings_page.dart';

class SettingsPage extends StatefulWidget {
  final dynamic params;

  const SettingsPage({
    super.key,
    this.params,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSettingsSection(
            title: localizations.generalSettings,
            children: [
              _buildSettingsItem(
                icon: Icons.language,
                title: localizations.languageSettings,
                subtitle: localizations.languageSettingsDesc,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSettingsPage(),
                    ),
                  );
                },
              ),
              _buildSettingsItem(
                icon: Icons.notifications,
                title: localizations.notificationSettings,
                subtitle: localizations.notificationSettingsDesc,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(localizations.notificationFeatureInDev)),
                  );
                },
              ),
              _buildSettingsItem(
                icon: Icons.security,
                title: localizations.privacySettings,
                subtitle: localizations.privacySettingsDesc,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.privacyFeatureInDev)),
                  );
                },
              ),
            ],
          ),
          _buildSettingsSection(
            title: localizations.appearanceSettings,
            children: [
              _buildSettingsItem(
                icon: Icons.palette,
                title: localizations.themeSettings,
                subtitle: localizations.themeSettingsDesc,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.themeFeatureInDev)),
                  );
                },
              ),
              _buildSettingsItem(
                icon: Icons.text_fields,
                title: localizations.fontSettings,
                subtitle: localizations.fontSettingsDesc,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.fontFeatureInDev)),
                  );
                },
              ),
            ],
          ),
          _buildSettingsSection(
            title: localizations.aboutSection,
            children: [
              _buildSettingsItem(
                icon: Icons.info,
                title: localizations.aboutApp,
                subtitle: localizations.aboutAppDesc,
                onTap: () {
                  _showAboutDialog();
                },
              ),
              _buildSettingsItem(
                icon: Icons.help,
                title: localizations.helpFeedback,
                subtitle: localizations.helpFeedbackDesc,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.helpFeatureInDev)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 8.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...children,
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.sp,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12.sp,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
      onTap: onTap,
    );
  }

  void _showAboutDialog() {
    final localizations = AppLocalizations.of(context)!;

    showAboutDialog(
      context: context,
      applicationName: localizations.appTitle,
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.flutter_dash,
        size: 48.sp,
        color: Theme.of(context).colorScheme.primary,
      ),
      children: [
        Text(
          localizations.aboutAppDescription,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}
