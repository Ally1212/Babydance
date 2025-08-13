import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/theme_store.p.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.themeSettings),
        elevation: 0,
      ),
      body: Consumer<ThemeStore>(
        builder: (context, themeStore, child) {
          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                localizations.selectTheme,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 16.h),
              _buildThemeOption(
                context: context,
                themeStore: themeStore,
                theme: AppThemeMode.lightBlue,
                title: localizations.lightBlueTheme,
                subtitle: localizations.lightModeDesc,
                icon: Icons.light_mode,
                color: Colors.lightBlue,
              ),
              SizedBox(height: 12.h),
              _buildThemeOption(
                context: context,
                themeStore: themeStore,
                theme: AppThemeMode.dark,
                title: localizations.darkMode,
                subtitle: localizations.darkModeDesc,
                icon: Icons.dark_mode,
                color: Colors.grey.shade700,
              ),
              SizedBox(height: 12.h),
              _buildThemeOption(
                context: context,
                themeStore: themeStore,
                theme: AppThemeMode.blue,
                title: localizations.blueMode,
                subtitle: localizations.blueModeDesc,
                icon: Icons.palette,
                color: Colors.indigo,
              ),
              SizedBox(height: 32.h),
              _buildPreviewSection(context, localizations),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required ThemeStore themeStore,
    required AppThemeMode theme,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = themeStore.currentTheme == theme;

    return Card(
      elevation: isSelected ? 4 : 1,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24.sp,
          ),
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
        trailing: Radio<AppThemeMode>(
          value: theme,
          groupValue: themeStore.currentTheme,
          onChanged: (AppThemeMode? value) {
            if (value != null) {
              themeStore.setThemeMode(value);
            }
          },
        ),
        onTap: () {
          themeStore.setThemeMode(theme);
        },
      ),
    );
  }

  Widget _buildPreviewSection(
      BuildContext context, AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.themePreview,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 16.h),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.preview,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.previewTitle,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            localizations.previewSubtitle,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(localizations.primaryButton),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(localizations.secondaryButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
