import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/add_task_popup.dart';
import 'package:uv_intern_task05_todo/components/my_text_form_field.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final taskController;

   const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
     required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Fixed height for the entire bottom bar
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Height for the navigation bar
              decoration: BoxDecoration(
                color: const Color(0xFF363636),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFF363636),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                currentIndex: currentIndex == 2 ? 0 : currentIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontSize: 12),
                elevation: 0,
                items: [
                  _buildNavItem(Icons.home, 'Index', 0),
                  _buildNavItem(Icons.calendar_today, 'Calendar', 1),
                  const BottomNavigationBarItem(
                    icon: SizedBox(width: 50, height: 50),
                    label: '',
                  ),
                  _buildNavItem(Icons.timer, 'Focuse', 3),
                  _buildNavItem(Icons.person, 'Profile', 4),
                ],
                onTap: (index) {
                  if (index == 2){
                    addTaskPopup(context, taskController, isUpdate: false);
                    return;
                  }
                  onTap(index);
                },
              ),
            ),
          ),
          // Floating Action Button
          Positioned(
            top: 0, // Position from top instead of bottom
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => addTaskPopup(context, taskController, isUpdate: false),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF7B61FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B61FF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Icon(
          icon,
          size: 24,
        ),
      ),
      label: label,
    );
  }
}