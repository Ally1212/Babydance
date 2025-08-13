import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';
import 'web_view_page.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.privacySettings),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildPrivacyItem(
            context: context,
            icon: Icons.privacy_tip,
            title: localizations.privacyPolicy,
            subtitle: localizations.privacyPolicyDesc,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    title: localizations.privacyPolicy,
                    assetPath: 'asset/privacy_policy.html',
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          _buildPrivacyItem(
            context: context,
            icon: Icons.description,
            title: localizations.termsOfService,
            subtitle: localizations.termsOfServiceDesc,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    title: localizations.termsOfService,
                    assetPath: 'asset/terms_of_service.html',
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          _buildPrivacyItem(
            context: context,
            icon: Icons.payment,
            title: localizations.termsOfPurchase,
            subtitle: localizations.termsOfPurchaseDesc,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    title: localizations.termsOfPurchase,
                    assetPath: 'asset/terms_of_purchase.html',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
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
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
