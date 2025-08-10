import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class LearningHomeScreen extends StatelessWidget {
  const LearningHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark
        ? const Color.fromARGB(255, 127, 127, 127)
        : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    // Get top courses dynamically
    final List<Map<String, dynamic>> courses = globalCourses;
    final List<Map<String, dynamic>> newCourses = courses
        .take(3)
        .toList(); // top 3 for "New Courses"
    final List<Map<String, dynamic>> recommendedCourses = courses
        .skip(3)
        .take(3)
        .toList(); // next 3 for "We Recommend"

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // App Header
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.all_inclusive, size: 44, color: textColor),
                    SizedBox(width: 4),
                    Text(
                      " | ",
                      style: TextStyle(fontSize: 34, color: textColor),
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        "LoopLab",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  style: TextStyle(color: textColor),
                  onChanged: (value) {
                    // Implement search logic later
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: secondaryTextColor),
                    hintText: "Search courses...",
                    hintStyle: TextStyle(color: secondaryTextColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Popular Topics
              Text(
                "Popular Topics",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    topicCard(
                      "Python",
                      "559 Courses",
                      Icons.code,
                      Colors.yellow[100]!,
                      textColor,
                      secondaryTextColor,
                    ),
                    topicCard(
                      "Flutter",
                      "202 Courses",
                      Icons.flutter_dash,
                      Colors.blue[100]!,
                      textColor,
                      secondaryTextColor,
                    ),
                    topicCard(
                      "JavaScript",
                      "312 Courses",
                      Icons.view_in_ar,
                      Colors.green[100]!,
                      textColor,
                      secondaryTextColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // New Courses
              sectionHeader("New Courses", textColor),
              const SizedBox(height: 10),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newCourses.length,
                  itemBuilder: (context, index) {
                    final course = newCourses[index];
                    return courseCard(
                      imageUrl: course["imageUrl"] ?? "",
                      title: course["title"] ?? "",
                      instructor: course["instructor"] ?? "",
                      rating: double.tryParse(course["rating"]?.toString() ?? '') ?? 0.0,
                      reviews: course["reviews"] ?? 0,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // We Recommend
              sectionHeader("We Recommend", textColor),
              const SizedBox(height: 10),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedCourses.length,
                  itemBuilder: (context, index) {
                    final course = recommendedCourses[index];
                    return courseCard(
                      imageUrl: course["imageUrl"] ?? "",
                      title: course["title"] ?? "",
                      instructor: course["instructor"] ?? "",
                      rating: course["rating"]?.toDouble() ?? 0.0,
                      reviews: course["reviews"] ?? 0,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget topicCard(
    String title,
    String subtitle,
    IconData icon,
    Color bgColor,
    Color textColor,
    Color secondaryTextColor,
  ) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.lightTextPrimary),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: secondaryTextColor),
          ),
        ],
      ),
    );
  }

  static Widget sectionHeader(String title, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text("See All", style: TextStyle(color: textColor)),
      ],
    );
  }

  static Widget courseCard({
    required String imageUrl,
    required String title,
    required String instructor,
    required double rating,
    required int reviews,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/looplab.png',
              height: 120,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 4),
          Text(
            instructor,
            style: TextStyle(fontSize: 12, color: secondaryTextColor),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange[700]),
              const SizedBox(width: 4),
              Text("$rating", style: TextStyle(color: textColor)),
              const SizedBox(width: 4),
              Text(
                "($reviews)",
                style: TextStyle(color: secondaryTextColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
