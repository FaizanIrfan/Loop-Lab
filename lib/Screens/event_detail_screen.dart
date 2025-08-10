import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class EventDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String imageUrl;
  final String type;
  final int attendees;

  const EventDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    // For simplicity, isRegistered is true here and static.
    bool isRegistered = false;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar with Event Image and gradient overlay
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: _getEventTypeColor(type),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _getEventTypeColor(type),
                          _getEventTypeColor(type).withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getEventIcon(type),
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Event Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Info Card
                  _buildEventInfoCard(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),

                  // Action Buttons
                  _buildActionButtons(isDark, textColor, isRegistered),
                  const SizedBox(height: 24),

                  // Description
                  _buildDescription(isDark, textColor, secondaryTextColor),
                  const SizedBox(height: 24),

                  // Agenda
                  _buildAgenda(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),

                  // Speakers
                  _buildSpeakers(isDark, textColor, secondaryTextColor, cardColor),
                  const SizedBox(height: 24),

                  // Attendees
                  _buildAttendees(isDark, textColor, secondaryTextColor, cardColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfoCard(
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
  ) {
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
        children: [
          _buildInfoRow(Icons.calendar_today, 'Date', date, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.access_time, 'Time', time, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, 'Location', location, isDark, secondaryTextColor, textColor),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.people, 'Attendees', '$attendees registered', isDark, secondaryTextColor, textColor),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    bool isDark,
    Color secondaryTextColor,
    Color textColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getEventTypeColor(type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _getEventTypeColor(type), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 12, color: secondaryTextColor, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isDark, Color textColor, bool isRegistered) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              // Implement register/unregister logic here or convert to StatefulWidget
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isRegistered ? (isDark ? AppColors.darkBackground : AppColors.lightBackground) : _getEventTypeColor(type),
              foregroundColor: isDark ? Colors.white : (isRegistered ? AppColors.dlTextSecondary2 : Colors.white),
              side: BorderSide(color: AppColors.dlTextSecondary2, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              isRegistered ? 'Registered' : 'Register Now',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: Add to calendar functionality
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _getEventTypeColor(type)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Icon(Icons.calendar_today, color: _getEventTypeColor(type)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: Share event functionality
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              foregroundColor: textColor,
            ),
            child: const Icon(Icons.share),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(bool isDark, Color textColor, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this event',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 12),
        Text(description,
            style: TextStyle(fontSize: 16, height: 1.6, color: secondaryTextColor)),
      ],
    );
  }

  Widget _buildAgenda(
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
  ) {
    final agenda = [
      {'time': '2:00 PM', 'title': 'Registration & Welcome'},
      {'time': '2:30 PM', 'title': 'Opening Keynote'},
      {'time': '3:15 PM', 'title': 'Technical Session 1'},
      {'time': '4:00 PM', 'title': 'Coffee Break'},
      {'time': '4:30 PM', 'title': 'Technical Session 2'},
      {'time': '5:15 PM', 'title': 'Q&A and Closing'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Event Agenda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
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
            children: agenda
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getEventTypeColor(type).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item['time']!,
                              style: TextStyle(
                                color: _getEventTypeColor(type),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title']!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakers(
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
  ) {
    final speakers = [
      {
        'name': 'John Smith',
        'role': 'Senior Developer',
        'company': 'Tech Corp',
      },
      {
        'name': 'Jane Doe',
        'role': 'Product Manager',
        'company': 'Innovation Inc',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Speakers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 16),
        ...speakers.map(
          (speaker) => Container(
            margin: const EdgeInsets.only(bottom: 12),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: _getEventTypeColor(type),
                  child: Text(
                    speaker['name']![0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(speaker['name']!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
                      const SizedBox(height: 4),
                      Text(speaker['role']!, style: TextStyle(fontSize: 14, color: secondaryTextColor)),
                      Text(speaker['company']!,
                          style: TextStyle(
                              fontSize: 14,
                              color: _getEventTypeColor(type),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendees(
    bool isDark,
    Color textColor,
    Color secondaryTextColor,
    Color cardColor,
  ) {
    final displayedCount = attendees >= 5 ? 5 : attendees;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attendees ($attendees)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 16),
        Container(
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
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 40,
                child: Stack(
                  children: List.generate(
                    displayedCount,
                    (index) => Positioned(
                      left: index * 20.0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: _getEventTypeColor(type),
                        child: Text(
                          'U${index + 1}',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (attendees > displayedCount)
                Expanded(
                  child: Text('and ${attendees - displayedCount} others',
                      style: TextStyle(fontSize: 16, color: secondaryTextColor)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getEventTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'workshop':
        return AppColors.greenAccent;
      case 'bootcamp':
        return AppColors.blueAccent;
      case 'meetup':
        return AppColors.orangeAccent;
      default:
        return AppColors.dlTextSecondary2;
    }
  }

  IconData _getEventIcon(String type) {
    switch (type.toLowerCase()) {
      case 'workshop':
        return Icons.build;
      case 'bootcamp':
        return Icons.school;
      case 'meetup':
        return Icons.people;
      default:
        return Icons.event;
    }
  }
}
