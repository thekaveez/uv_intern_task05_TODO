import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// display error message to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      )
  );
}

void postTask(final controller, BuildContext context) async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  if (controller.text.isNotEmpty) {
    // Add task to firestore
    await FirebaseFirestore.instance.collection('tasks').add({
      'UserId': currentUser.email,
      'TaskName': controller.text,
      'priority' : 'default',
      'category' : 'default',
      'categoryColor' : 'default',
      'categoryIcon' : 'default',
    });
    // Clear the text field
    controller.clear();
    Navigator.pop(context);
  } else {
    displayMessageToUser('Please enter a task name', context);
  }

}

void updateTask(final controller, BuildContext context, String docId) async {
  if (controller.text.isNotEmpty) {
    // Update task in firestore
    await FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      'TaskName': controller.text,
    });
    // Clear the text field
    controller.clear();
    Navigator.pop(context);
  } else {
    displayMessageToUser('Please enter a task name', context);
  }
}

 void updateTaskPriority(String priority, String docId) async {
    // Update task in firestore
    await FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      'priority': priority,
    });
  }

  void updateTaskCategory(String category, String categoryColor, String categoryIcon, String docId) async {
    // Update task in firestore
    await FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      'category': category,
      'categoryColor': categoryColor,
      'categoryIcon': categoryIcon,
    });
  }

void deleteTask(String docId) async {
  // Delete task from firestore
  await FirebaseFirestore.instance.collection('tasks').doc(docId).delete();
}





Color colorFromHex(String hexColor) {
  try {
    // Check if the hex color starts with 'Color(' and ends with ')'
    if (hexColor.startsWith('Color(') && hexColor.endsWith(')')) {
      // Extract the hex value from the string
      hexColor = hexColor.substring(6, hexColor.length - 1); // Get the substring between 'Color(' and ')'
    } else if (hexColor.startsWith('#')) {
      // Remove '#' if present
      hexColor = hexColor.replaceFirst('#', '');
    }

    // Ensure color string is 6 or 8 characters long
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add alpha if it's missing
    } else if (hexColor.length != 8) {
      print("Invalid hex color format: $hexColor");
      return Colors.grey; // Return a default color
    }

    return Color(int.parse('0x$hexColor')); // Parse as an integer
  } catch (e) {
    print("Error parsing color: $e, using default color.");
    return Colors.grey; // Return a default color if parsing fails
  }
}