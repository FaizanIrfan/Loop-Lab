import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Helper/helper_functions.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/screens/course_detail_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Flutter',
    'React',
    'AI/ML',
    'Web Dev',
    'Mobile',
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> courses = globalCourses;
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Courses',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryBlue : cardColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Courses List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: courses.length, // Replace with actual course count
                itemBuilder: (context, index) {
                  return _buildCourseCard(
                    isDark,
                    index,
                    textColor,
                    secondaryTextColor,
                    cardColor,
                    courses,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: globalRole == "teacher"
            ? FloatingActionButton(
                onPressed: () => _showAddCourseSheet(context),
                backgroundColor: AppColors.primaryBlue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }

  Widget _buildCourseCard(
    bool isDark,
    int index,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
    List<Map<String, dynamic>> courses,
  ) {
    final course = courses[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // Course Image
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryBlue,
                  AppColors.primaryBlue.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 60,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      course['price'] as String,
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'by ${course['instructor'] as String}',
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      course['duration'] as String,
                      style: TextStyle(fontSize: 12, color: secondaryTextColor),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.play_lesson,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      course['lessons'] as String,
                      style: TextStyle(fontSize: 12, color: secondaryTextColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      course['rating'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${course['students'] as String} students)',
                      style: TextStyle(fontSize: 12, color: secondaryTextColor),
                    ),
                  ],
                ),

                if (course['progress'] != null) ...[
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '${((course['progress'] as double) * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: course['progress'] as double,
                        backgroundColor: isDark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to course details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailScreen(course: course),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      course['progress'] != null
                          ? 'Continue Learning'
                          : 'Enroll Now',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showAddCourseSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController instructorCtrl = TextEditingController();
  final TextEditingController durationCtrl = TextEditingController();
  final TextEditingController lessonsCtrl = TextEditingController();
  final TextEditingController ratingCtrl = TextEditingController();
  final TextEditingController studentsCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController imageCtrl = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add New Course",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField("Title", titleCtrl),
                _buildTextField("Instructor", instructorCtrl),
                _buildTextField("Duration", durationCtrl),
                _buildTextField("Lessons", lessonsCtrl),
                _buildTextField("Rating", ratingCtrl),
                _buildTextField("Students", studentsCtrl),
                _buildTextField("Price", priceCtrl),
                _buildTextField("Image URL", imageCtrl),

                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addCourseToFirestore(
                        titleCtrl.text,
                        instructorCtrl.text,
                        durationCtrl.text,
                        lessonsCtrl.text,
                        ratingCtrl.text,
                        studentsCtrl.text,
                        priceCtrl.text,
                        imageCtrl.text,
                      );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text(
                    "Add Course",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Enter $label" : null,
    ),
  );
}
