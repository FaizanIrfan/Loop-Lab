import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:loop_lab/LearningApp.dart';
import 'package:loop_lab/Tabs/courses_screen.dart';
import 'package:loop_lab/Tabs/events_screen.dart';
import 'package:loop_lab/Tabs/profile_screen.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/widgets/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:uicons/uicons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    // Pass required params to DashboardScreen (not const because onTabSelected is a runtime closure)
    List<Widget> widgetList = [
      const LearningHomeScreen(),
      const CoursesScreen(),
      const EventsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true, // lets the circle nav float nicely above body
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(
            UIcons.solidRounded.home,
            size: 22,
            color: AppColors.dlTextSecondary2,
          ),
          Icon(
            UIcons.solidRounded.book_open_cover,
            size: 22,
            color: AppColors.dlTextSecondary2,
          ),
          Icon(
            UIcons.solidRounded.calendar,
            size: 22,
            color: AppColors.dlTextSecondary2,
          ),
          Icon(
            UIcons.solidRounded.user,
            size: 22,
            color: AppColors.dlTextSecondary2,
          ),
        ],
        // Simple labels shown when inactive — you can switch to icons if you prefer
        inactiveIcons: [
          Icon(
            UIcons.solidRounded.home,
            size: 22,
            color: AppColors.dlTextPrimary2,
          ),
          Icon(
            UIcons.solidRounded.book_open_cover,
            size: 22,
            color: AppColors.dlTextPrimary2,
          ),
          Icon(
            UIcons.solidRounded.calendar,
            size: 22,
            color: AppColors.dlTextPrimary2,
          ),
          Icon(
            UIcons.solidRounded.user,
            size: 22,
            color: AppColors.dlTextPrimary2,
          ),
        ],
        levels: const ["Home", "Courses", "Events", "Profile"],
        color: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
        circleColor: isDark
          ? AppColors.darkIconBackground
          : AppColors.lightIconBackground,
        height: 70,
        circleWidth: 60,
        activeIndex: navigationProvider.selectedIndex, // required param
        onTap: (index) {
          navigationProvider.setSelectedIndex(index);
        },
        // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 18),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        // shadowColor: Colors.black54,
        elevation: 8,
      ),
      body: widgetList[navigationProvider.selectedIndex],
    );
  }
}

// ProfileScreen (unchanged logic — adjusted destructive color to AppColors.errorRed)
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
//     final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
//     final secondaryTextColor =
//         isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
//     final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

//     return Scaffold(
//       backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Profile',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: textColor,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       AdaptiveTheme.of(context).toggleThemeMode();
//                     },
//                     icon: Icon(
//                       isDark ? Icons.light_mode : Icons.dark_mode,
//                       color: textColor,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromRGBO(0, 0, 0, 0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     const CircleAvatar(
//                       radius: 50,
//                       backgroundColor: AppColors.primaryBlue,
//                       child: Icon(
//                         Icons.person,
//                         size: 50,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'John Doe',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: textColor,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Student',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: secondaryTextColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               _buildProfileOption(
//                 context: context,
//                 icon: Icons.edit,
//                 title: 'Edit Profile',
//                 isDark: isDark,
//                 textColor: textColor,
//                 secondaryTextColor: secondaryTextColor,
//                 cardColor: cardColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const EditProfileScreen()),
//                   );
//                 },
//               ),
//               _buildProfileOption(
//                 context: context,
//                 icon: Icons.notifications,
//                 title: 'Notifications',
//                 isDark: isDark,
//                 textColor: textColor,
//                 secondaryTextColor: secondaryTextColor,
//                 cardColor: cardColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const NotificationsSettingsScreen()),
//                   );
//                 },
//               ),
//               _buildProfileOption(
//                 context: context,
//                 icon: Icons.security,
//                 title: 'Privacy & Security',
//                 isDark: isDark,
//                 textColor: textColor,
//                 secondaryTextColor: secondaryTextColor,
//                 cardColor: cardColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
//                   );
//                 },
//               ),
//               _buildProfileOption(
//                 context: context,
//                 icon: Icons.help,
//                 title: 'Help & Support',
//                 isDark: isDark,
//                 textColor: textColor,
//                 secondaryTextColor: secondaryTextColor,
//                 cardColor: cardColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
//                   );
//                 },
//               ),
//               _buildProfileOption(
//                 context: context,
//                 icon: Icons.logout,
//                 title: 'Logout',
//                 isDark: isDark,
//                 isDestructive: true,
//                 textColor: textColor,
//                 secondaryTextColor: secondaryTextColor,
//                 cardColor: cardColor,
//                 onTap: () {
//                   // Handle logout logic
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileOption({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required bool isDark,
//     required Color textColor,
//     required Color secondaryTextColor,
//     required Color cardColor,
//     required VoidCallback onTap,
//     bool isDestructive = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: isDestructive ? AppColors.redAccent : AppColors.primaryBlue,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: isDestructive ? AppColors.redAccent : textColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         trailing: Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: secondaryTextColor,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
