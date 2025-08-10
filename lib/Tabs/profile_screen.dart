import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/Screens/profile_sub_screens/edit_profile_screen.dart';
import 'package:loop_lab/Screens/profile_sub_screens/notifications_settings_screen.dart';
import 'package:loop_lab/Screens/profile_sub_screens/privacy_security_screen.dart';
import 'package:loop_lab/Screens/profile_sub_screens/help_support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userId = globalUid;
    if (userId.isEmpty) return;

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _name = data['name'] ?? '';
          _email = data['email'] ?? '';
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = globalUid;
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.lightText : AppColors.darkText;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          elevation: 0,
          title: Text(
            'Account',
            style: TextStyle(color: textColor, fontWeight: FontWeight.w900),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Image.asset('assets/images/Avatar.png'),
              ),
              const SizedBox(height: 8),
              Text(
                _name ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
              ),
              Text(
                _email ?? '',
                style: TextStyle(fontSize: 14, color: secondaryTextColor),
              ),
              const SizedBox(height: 32),
              _buildProfileOption(
                title: 'Edit Account',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(userId: userId),
                    ),
                  );
                },
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 16),
              _buildProfileOption(
                title: 'Notifications Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsSettingsScreen(),
                    ),
                  );
                },
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Dark Theme",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      value: isDark,
                      onChanged: (value) {
                        if (value) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileOption(
                title: 'Privacy & Security',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacySecurityScreen(),
                    ),
                  );
                },
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 16),
              _buildProfileOption(
                title: 'Help & Support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportScreen(),
                    ),
                  );
                },
                textColor: textColor,
                secondaryTextColor: secondaryTextColor,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully!')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? AppColors.lightBackground : AppColors.darkBackground,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: isDark ? AppColors.lightBackground : AppColors.darkBackground,
                  ),
                  icon: const Icon(Icons.logout, size: 24),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String title,
    required VoidCallback onTap,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20, color: secondaryTextColor),
          ],
        ),
      ),
    );
  }
}
