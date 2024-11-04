import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uv_intern_task05_todo/pages/home_content.dart';
import 'package:uv_intern_task05_todo/pages/profile_page.dart';

import '../components/my_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final taskController = TextEditingController();
  String _name = 'Your Name';
  String? _imageBase64;




  // logout
  void signOut() {
    FirebaseAuth.instance.signOut();
  }


  final List<Widget> _pages = [
    const HomeContent(),
    const Text('Calendar Page'),
    const Text('Add Page'),
    const Text('Focus Page'),
    const ProfilePage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Your Name';
      _imageBase64 = prefs.getString('profile_image');
    });
  }

  ImageProvider _getProfileImage() {
    if (_imageBase64 != null && _imageBase64!.isNotEmpty) {
      return MemoryImage(base64Decode(_imageBase64!));
    }
    return const AssetImage('assets/profile.jpg');
  }



  @override
  Widget build(BuildContext context) {// Keep this as false

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white70,
        title: Center(child: Text('Hello ${_name}')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: _getProfileImage(),
            ),
          ),
        ],
      ),
      body: Center(
            child: _pages[_selectedIndex],
          ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        taskController: taskController,
      ),

    );
  }
}
