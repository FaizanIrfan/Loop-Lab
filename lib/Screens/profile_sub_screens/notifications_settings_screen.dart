import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _enablePushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _courseUpdates = true;
  bool _eventReminders = true;
  bool _chatMessages = true;

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
          'Notifications',
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
              'General Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildToggleTile(
              title: 'Push Notifications',
              subtitle: 'Receive alerts directly on your device',
              value: _enablePushNotifications,
              onChanged: (value) {
                setState(() {
                  _enablePushNotifications = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'Email Notifications',
              subtitle: 'Get updates via email',
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'SMS Notifications',
              subtitle: 'Receive important alerts via text message',
              value: _smsNotifications,
              onChanged: (value) {
                setState(() {
                  _smsNotifications = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            const SizedBox(height: 32),
            Text(
              'Content Specific Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildToggleTile(
              title: 'Course Updates',
              subtitle: 'Be notified about new lessons, quizzes, and announcements',
              value: _courseUpdates,
              onChanged: (value) {
                setState(() {
                  _courseUpdates = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'Event Reminders',
              subtitle: 'Get reminders for upcoming events you\'ve registered for',
              value: _eventReminders,
              onChanged: (value) {
                setState(() {
                  _eventReminders = value;
                });
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildToggleTile(
              title: 'Chat Messages',
              subtitle: 'Receive alerts for new direct and group messages',
              value: _chatMessages,
              onChanged: (value) {
                setState(() {
                  _chatMessages = value;
                });
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
                  // Save notification settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notification settings saved!')),
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
