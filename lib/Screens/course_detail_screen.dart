import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class CourseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> course;
  
  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  bool isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Check if user is enrolled (you can get this from your database)
    isEnrolled = widget.course['progress'] != null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar with Course Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryBlue,
                      AppColors.primaryBlue.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.course['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    if (isEnrolled)
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: LinearProgressIndicator(
                          value: widget.course['progress'] as double? ?? 0.0,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          
          // Course Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Info
                  _buildCourseInfo(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),
                  
                  // Enroll/Continue Button
                  _buildActionButton(isDark),
                  const SizedBox(height: 24),
                  
                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: secondaryTextColor,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Lessons'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Tab Content
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOverviewTab(isDark, textColor, secondaryTextColor),
                        _buildLessonsTab(isDark, textColor, secondaryTextColor, cardColor),
                        _buildReviewsTab(isDark, textColor, secondaryTextColor, cardColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseInfo(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryBlue,
                child: Text(
                  (widget.course['instructor'] as String)[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course['instructor'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'Instructor',
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
                  color: AppColors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.course['price'] as String,
                  style: const TextStyle(
                    color: AppColors.greenAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              _buildInfoItem(Icons.access_time, widget.course['duration'] as String, secondaryTextColor),
              const SizedBox(width: 20),
              _buildInfoItem(Icons.play_lesson, widget.course['lessons'] as String, secondaryTextColor),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              _buildInfoItem(Icons.star, widget.course['rating'] as String, secondaryTextColor),
              const SizedBox(width: 20),
              _buildInfoItem(Icons.people, '${widget.course['students']} students', secondaryTextColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color secondaryTextColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: secondaryTextColor,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isEnrolled = !isEnrolled;
          });
          // Handle enrollment logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          isEnrolled ? 'Continue Learning' : 'Enroll Now',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(bool isDark, Color textColor, Color secondaryTextColor) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this course',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This comprehensive course will teach you everything you need to know about ${widget.course['title']}. You\'ll learn from industry experts and build real-world projects.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 20),
          
          Text(
            'What you\'ll learn',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          
          ...List.generate(5, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.greenAccent,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Master the fundamentals and advanced concepts',
                    style: TextStyle(
                      fontSize: 16,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildLessonsTab(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        final isCompleted = isEnrolled && index < 8;
        final isLocked = !isEnrolled;
        
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
            leading: CircleAvatar(
              backgroundColor: isCompleted 
                  ? AppColors.greenAccent
                  : (isLocked ? Colors.grey : AppColors.primaryBlue),
              child: Icon(
                isCompleted 
                    ? Icons.check
                    : (isLocked ? Icons.lock : Icons.play_arrow),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              'Lesson ${index + 1}: Introduction to Basics',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            subtitle: Text(
              '12:30 min',
              style: TextStyle(
                color: secondaryTextColor,
              ),
            ),
            trailing: isLocked 
                ? null
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: secondaryTextColor,
                  ),
            onTap: isLocked ? null : () {
              // Navigate to video player
            },
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryBlue,
                    child: Text(
                      'U${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (starIndex) => Icon(
                            Icons.star,
                            size: 16,
                            color: starIndex < 4 ? Colors.amber : Colors.grey,
                          )),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '2 days ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Great course! The instructor explains everything clearly and the examples are very helpful.',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
