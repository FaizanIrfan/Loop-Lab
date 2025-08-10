import 'package:cloud_firestore/cloud_firestore.dart';

// 🌍 Global variables
String globalFullName = "";
String globalEmail = "";
String globalPhoneNumber = "";
String globalUid = "";
String globalRole = "";
List<Map<String, dynamic>> globalCourses = [];
List<Map<String, dynamic>> globalEvents = [];
List<Map<String, dynamic>> globalAnnouncement = [];

// 📄 Function to fetch user data by UID
Future<void> fetchUserData(String uid) async {
  try {
    DocumentSnapshot userDoc = 
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      // Assign to global variables
      globalFullName = userDoc['fullName'] ?? '';
      globalEmail = userDoc['email'] ?? '';
      globalPhoneNumber = userDoc['phoneNumber'] ?? '';
      globalUid = userDoc['uid'] ?? '';
      globalRole = userDoc['role'] ?? '';

      print("✅ User data fetched successfully");
      print("Full Name: $globalFullName");
      print("Email: $globalEmail");
      print("Phone: $globalPhoneNumber");
      print("UID: $globalUid");
    } else {
      print("❌ No user found with uid: $uid");
    }
  } catch (e) {
    print("🔥 Error fetching user data: $e");
  }
}

Future<void> fetchAllCourses() async {
  try {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('courses').get();

    // Store all documents in the global list
    globalCourses = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // include document ID
        ...doc.data() as Map<String, dynamic>
      };
    }).toList();

    print("Fetched ${globalCourses.length} courses");
  } catch (e) {
    print("Error fetching courses: $e");
  }
}

Future<void> fetchAllEvents() async {
  try {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('events').get();

    final fetchedEvents = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      };
    }).toList();

    // Ensure no duplicates based on 'id'
    final uniqueEvents = {
      for (var event in fetchedEvents) event['id']: event
    }.values.toList();

    globalEvents = uniqueEvents;

    print("Fetched ${globalEvents.length} unique events");
  } catch (e) {
    print("Error fetching events: $e");
  }
}

Future<void> fetchAllAnnouncements() async {
  try {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('announcement').get();

    final fetchedAnnouncement = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      };
    }).toList();

    // Ensure no duplicates based on 'id'
    final uniqueAnnouncement = {
      for (var announcement in fetchedAnnouncement) announcement['id']: announcement
    }.values.toList();

    globalAnnouncement = uniqueAnnouncement;

    print("Fetched ${globalAnnouncement.length} unique announcement");
  } catch (e) {
    print("Error fetching announcement: $e");
  }
}
