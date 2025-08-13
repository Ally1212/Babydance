import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../provider/locale_store.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.language),
      ),
      body: Consumer<LocaleStore>(
        builder: (context, localeStore, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('中文'),
                trailing: localeStore.locale.languageCode == 'zh'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  localeStore.setLocale(const Locale('zh'));
                },
              ),
              ListTile(
                title: const Text('English'),
                trailing: localeStore.locale.languageCode == 'en'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  localeStore.setLocale(const Locale('en'));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
