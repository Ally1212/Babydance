import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/route_name.dart';
import 'components/set_theme_demo.dart';
import 'components/head_userbox.dart';

class MyPersonal extends StatefulWidget {
  @override
  State<MyPersonal> createState() => _MyPersonalState();
}

class _MyPersonalState extends State<MyPersonal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildSettingsButton(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Icon(
            Icons.settings,
            size: 24.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            localizations.settings,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            localizations.appSettings,
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
          onTap: () {
            Navigator.pushNamed(context, RouteName.settings);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.myPersonal),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 24.sp,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.settings);
            },
            tooltip: localizations.settings,
          ),
        ],
      ),
      body: Column(
        children: [
          HeadUserBox(),
          SetThemeDemo(),
          SizedBox(height: 20.h),
          _buildSettingsButton(context),
        ],
      ),
    );
  }
}
