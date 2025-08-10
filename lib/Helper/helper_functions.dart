import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addCourseToFirestore(
  String title,
  String instructor,
  String duration,
  String lessons,
  String rating,
  String students,
  String price,
  String image,
) async {
  try {
    // Generate a random document ID
    String courseId = FirebaseFirestore.instance.collection('courses').doc().id;

    // Save the data to Firestore
    await FirebaseFirestore.instance.collection('courses').doc(courseId).set({
      'courseId': courseId,
      'title': title,
      'instructor': instructor,
      'duration': duration,
      'lessons': lessons,
      'rating': rating,
      'students': students,
      'price': price,
      'image': image,
    });

    // Navigate to CoursesScreen after saving
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CoursesScreen()),
    // );
  } catch (e) {
    print("some error");
  }
}

Future<void> addEventToFirestore(
  String title,
  String date,
  String time,
  String location,
  String isUpcoming,
  String imageUrl,
  String description,
  BuildContext context,
) async {
  try {
    // Generate a random document ID
    String eventId = FirebaseFirestore.instance.collection('events').doc().id;

    // Save the data to Firestore
    await FirebaseFirestore.instance.collection('events').doc(eventId).set({
      'eventId': eventId,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'isUpcoming': isUpcoming,
      'imageUrl': imageUrl,
      'description':description,
    });

    // Navigate to CoursesScreen after saving
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CoursesScreen()),
    // );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future<void> addAnnouncementToFirestore(
  String title,
  String date,
  String content,
  String isNew,
  BuildContext context,
) async {
  try {
    // Generate a random document ID
    String announcementId = FirebaseFirestore.instance.collection('announcement').doc().id;

    // Save the data to Firestore
    await FirebaseFirestore.instance.collection('announcement').doc(announcementId).set({
      'announcementId': announcementId,
      'title': title,
      'date': date,
      'content': content,
      'isNew': isNew,
    });

    // Navigate to CoursesScreen after saving
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CoursesScreen()),
    // );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future<Map<String, dynamic>?> fetchUserById(String userId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users') // change to your actual collection name
        .doc(userId)
        .get();

    if (userDoc.exists) {
      // Return user data as a Map
      return userDoc.data() as Map<String, dynamic>;
    } else {
      print("No user found with id: $userId");
      return null;
    }
  } catch (e) {
    print("Error fetching user: $e");
    return null;
  }
}
