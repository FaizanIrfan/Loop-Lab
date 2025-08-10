import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & Support',
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
              'Need Help?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'We\'re here to assist you with any questions or issues you might have.',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            _buildOptionCard(
              icon: Icons.chat_outlined,
              title: 'Chat with Support',
              description: 'Get instant help from our AI assistant or a live agent.',
              onTap: () {
                // Navigate to chat support
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening chat support...')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildOptionCard(
              icon: Icons.email_outlined,
              title: 'Email Us',
              description: 'Send us an email and we\'ll get back to you within 24 hours.',
              onTap: () {
                // Open email client
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening email client...')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildOptionCard(
              icon: Icons.help_outline,
              title: 'FAQs',
              description: 'Find answers to common questions in our extensive FAQ section.',
              onTap: () {
                // Navigate to FAQ screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigating to FAQs...')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            _buildOptionCard(
              icon: Icons.article_outlined,
              title: 'Documentation',
              description: 'Explore detailed guides and articles about LoopLab features.',
              onTap: () {
                // Navigate to documentation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening documentation...')),
                );
              },
              isDark: isDark,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              cardColor: cardColor,
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                'LoopLab v1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required bool isDark,
    required Color textColor,
    required Color secondaryTextColor,
    required Color cardColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
