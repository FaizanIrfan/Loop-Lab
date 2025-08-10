import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Tabs/chat_screen.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/widgets/navigation_provider.dart'; // Import NavigationProvider
import 'package:provider/provider.dart'; // Import Provider

class DashboardScreen extends StatefulWidget {
  final String userRole;
  
  const DashboardScreen({super.key, this.userRole = 'Student'});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning! 👋',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Welcome back to LoopLab',
                        style: TextStyle(
                          fontSize: 16,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      AdaptiveTheme.of(context).toggleThemeMode();
                    },
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: textColor,
                    ),
                  ),
                  // Removed the bell icon as per request
                ],
              ),
              const SizedBox(height: 24),
              
              // Stats Cards
              _buildStatsSection(isDark, textColor, secondaryTextColor, cardColor),
              const SizedBox(height: 24),
              
              // Quick Actions
              _buildQuickActions(isDark, textColor, cardColor),
              const SizedBox(height: 24),
              
              // Recent Activity
              _buildRecentActivity(isDark, textColor, secondaryTextColor, cardColor),
              const SizedBox(height: 24),
              
              // Upcoming Events
              _buildUpcomingEvents(isDark, textColor, secondaryTextColor, cardColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Courses Completed',
                '12',
                Icons.school_outlined,
                AppColors.greenAccent,
                isDark,
                textColor,
                secondaryTextColor,
                cardColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Events Attended',
                '8',
                Icons.event_outlined,
                AppColors.blueAccent,
                isDark,
                textColor,
                secondaryTextColor,
                cardColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Badges Earned',
                '5',
                Icons.emoji_events_outlined,
                AppColors.orangeAccent,
                isDark,
                textColor,
                secondaryTextColor,
                cardColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Leaderboard Rank',
                '#23',
                Icons.leaderboard_outlined,
                AppColors.redAccent,
                isDark,
                textColor,
                secondaryTextColor,
                cardColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isDark, Color textColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Browse Courses',
                Icons.play_circle_outline,
                AppColors.primaryBlue,
                isDark,
                textColor,
                cardColor,
                () {
                  // Update bottom navbar index and navigate
                  Provider.of<NavigationProvider>(context, listen: false).setSelectedIndex(1); // Index for Courses
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Join Live Session',
                Icons.videocam_outlined,
                AppColors.greenAccent,
                isDark,
                textColor,
                cardColor,
                () {
                  // Navigate to live sessions
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'View Events',
                Icons.calendar_today_outlined,
                AppColors.blueAccent,
                isDark,
                textColor,
                cardColor,
                () {
                  // Update bottom navbar index and navigate
                  Provider.of<NavigationProvider>(context, listen: false).setSelectedIndex(2); // Index for Events
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Chat with Team',
                Icons.chat_outlined,
                AppColors.orangeAccent,
                isDark,
                textColor,
                cardColor,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, bool isDark, Color textColor, Color cardColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          child: Column(
            children: [
              _buildActivityItem(
                'Completed "Flutter Basics" course',
                '2 hours ago',
                Icons.school_outlined,
                AppColors.greenAccent,
                isDark,
                textColor,
                secondaryTextColor,
              ),
              _buildActivityItem(
                'Attended "AI Workshop" event',
                '1 day ago',
                Icons.event_outlined,
                AppColors.blueAccent,
                isDark,
                textColor,
                secondaryTextColor,
              ),
              _buildActivityItem(
                'Earned "Quick Learner" badge',
                '3 days ago',
                Icons.emoji_events_outlined,
                AppColors.orangeAccent,
                isDark,
                textColor,
                secondaryTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color, bool isDark, Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<NavigationProvider>(context, listen: false).setSelectedIndex(2); // Index for Events
              },
              child: const Text(
                'View All',
                style: TextStyle(color: AppColors.primaryBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
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
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.event,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'React Native Workshop',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tomorrow, 2:00 PM',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
