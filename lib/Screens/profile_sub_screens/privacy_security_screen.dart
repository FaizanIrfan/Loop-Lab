import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _twoFactorAuth = false;
  bool _dataSharing = false;
  bool _activityTracking = true;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Privacy & Security',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildOptionTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: () {
                // Navigate to change password screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigating to Change Password')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security to your account',
              value: _twoFactorAuth,
              onChanged: (value) {
                setState(() {
                  _twoFactorAuth = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            const SizedBox(height: 32),
            Text(
              'Data & Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildToggleTile(
              title: 'Allow Data Sharing',
              subtitle: 'Share anonymous usage data to help improve the app',
              value: _dataSharing,
              onChanged: (value) {
                setState(() {
                  _dataSharing = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'Activity Tracking',
              subtitle: 'Allow tracking of your in-app activities for personalized content',
              value: _activityTracking,
              onChanged: (value) {
                setState(() {
                  _activityTracking = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildOptionTile(
              icon: Icons.download_for_offline_outlined,
              title: 'Download My Data',
              subtitle: 'Request a copy of your personal data',
              onTap: () {
                // Handle data download request
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Requesting data download...')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Save privacy settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy settings saved!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
    required Color textColor,
    required Color secondaryTextColor,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: secondaryTextColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: secondaryTextColor,
        ),
        onTap: onTap,
        tileColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
    required Color textColor,
    required Color secondaryTextColor,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: secondaryTextColor,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryBlue,
        inactiveTrackColor: isDark ? Colors.grey[700] : Colors.grey[300],
        tileColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
