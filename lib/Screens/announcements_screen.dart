import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Helper/helper_functions.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    final List<Map<String, dynamic>> allAnnouncements = globalAnnouncement;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Announcements',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      floatingActionButton: globalRole == "admin"
          ? FloatingActionButton(
              onPressed: () => _showAddAnnouncementSheet(context),
              backgroundColor: AppColors.primaryBlue,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: allAnnouncements.length,
        itemBuilder: (context, index) {
          final announcement = allAnnouncements[index];

          // Handle isNew as bool or string
          bool isNewValue = false;
          final rawIsNew = announcement['isNew'];
          if (rawIsNew is bool) {
            isNewValue = rawIsNew;
          } else if (rawIsNew is String) {
            isNewValue = rawIsNew.toLowerCase() == 'true';
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        (announcement['title'] ?? '') as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if (isNewValue)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greenAccent.withAlpha(26),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: AppColors.greenAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  (announcement['date'] ?? '') as String,
                  style: TextStyle(fontSize: 12, color: secondaryTextColor),
                ),
                const SizedBox(height: 16),
                Text(
                  (announcement['content'] ?? '') as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void _showAddAnnouncementSheet(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isNew = true;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // allows full height
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // show above keyboard
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Announcement",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Title
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Date
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Date",
                  border: OutlineInputBorder(),
                  hintText: "YYYY-MM-DD",
                ),
              ),
              const SizedBox(height: 12),

              // Content
              TextField(
                controller: contentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Is New
              Row(
                children: [
                  const Text("Is New?"),
                  Switch(
                    value: isNew,
                    onChanged: (val) {
                      isNew = val;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addAnnouncementToFirestore(
                      titleController.text.trim(),
                      dateController.text.trim(),
                      contentController.text.trim(),
                      isNew.toString(),
                      context,
                    );
                    Navigator.pop(context); // close sheet
                  },
                  child: const Text("Save Announcement"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
