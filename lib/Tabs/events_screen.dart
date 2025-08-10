import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Helper/helper_functions.dart';
import 'package:loop_lab/Screens/event_detail_screen.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/Screens/announcements_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _allEvents = globalEvents;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredEvents() {
    return _allEvents.where((event) => event['isUpcoming'] == "true").toList();
  }

  @override
  Widget build(BuildContext context) {
    // print(_getFilteredEvents(isUpcoming));
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Events',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnnouncementsScreen(),
                ),
              );
            },
            icon: Icon(Icons.campaign_outlined, color: textColor),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.dlTextSecondary2,
          unselectedLabelColor: secondaryTextColor,
          indicatorColor: AppColors.dlTextSecondary2,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      // FAB appears only for teachers
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: globalRole == "admin"
            ? FloatingActionButton(
                onPressed: () => _showAddEventSheet(context),
                backgroundColor: AppColors.primaryBlue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventList(
            true,
            isDark,
            textColor,
            secondaryTextColor,
            cardColor,
          ),
          _buildEventList(
            false,
            isDark,
            textColor,
            secondaryTextColor,
            cardColor,
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(
    bool isUpcoming,
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
  ) {
    final events = _getFilteredEvents();
    print(_getFilteredEvents());
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailScreen(
                  title: event['title'] ?? '',
                  date: event['date'] ?? '',
                  time: event['time'] ?? '',
                  location: event['location'] ?? '',
                  description: event['description'] ?? '',
                  imageUrl: event['imageUrl'] ?? '',
                  type: '',
                  attendees: 10,
                ),
              ),
            );
          },
          child: Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: screenWidth * 0.04),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      event['imageUrl'] as String,
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            color: isDark ? Colors.white : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'] as String,
                          style: TextStyle(
                            color: textColor,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['date'] as String,
                          style: TextStyle(
                            color: AppColors.dlTextSecondary2,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: secondaryTextColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    event['time'] as String,
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: secondaryTextColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    event['location'] as String,
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showAddEventSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController isUpcomingCtrl = TextEditingController();
  final TextEditingController imageUrlCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

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
                  "Add New Event",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildTextField("Title", titleCtrl),
                _buildTextField("Date (YYYY-MM-DD)", dateCtrl),
                _buildTextField("Time (HH:MM)", timeCtrl),
                _buildTextField("Location", locationCtrl),
                _buildTextField("Is Upcoming? (true/false)", isUpcomingCtrl),
                _buildTextField("Image URL", imageUrlCtrl),
                _buildTextField("Description", descriptionCtrl, maxLines: 3),

                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await addEventToFirestore(
                        titleCtrl.text,
                        dateCtrl.text,
                        timeCtrl.text,
                        locationCtrl.text,
                        isUpcomingCtrl.text,
                        imageUrlCtrl.text,
                        descriptionCtrl.text,
                        ctx,
                      );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text("Add Event", style: TextStyle(color: Colors.white)),
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

Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => value == null || value.isEmpty ? "Enter $label" : null,
    ),
  );
}
