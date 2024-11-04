import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/task_list_item.dart';
import '../utils/color_utils.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.email!;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('UserId', isEqualTo: userId)
          .orderBy('TaskName', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      'assets/checklist.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'What do you want to do today?',
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your tasks',
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      hintText: 'Search for your task...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.transparent,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Color(0xff979797)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Color(0xff979797)),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final task = snapshot.data!.docs[index].data()
                      as Map<String, dynamic>;
                      final String taskName = task['TaskName'] ?? 'Unnamed Task';
                      final String category = task['category'] ?? 'Uncategorized';
                      final String priority = task['priority'] ?? '0';

                      IconData iconData = Icons.category;
                      if (task['categoryIcon'] != null) {
                        try {
                          String iconString = task['categoryIcon'] as String;
                          if (iconString.contains('0x')) {
                            int codePoint = int.tryParse(
                              iconString.split('(0x')[1].split(')')[0],
                              radix: 16,
                            ) ?? 0xe0b0;
                            iconData = IconData(
                              codePoint,
                              fontFamily: 'MaterialIcons',
                            );
                          }
                        } catch (e) {
                          print('Error parsing icon: $e');
                        }
                      }

                      Color color = task['categoryColor'] != null
                          ? ColorUtils.colorFromHex(task['categoryColor'])
                          : Colors.grey;

                      return TaskListItem(
                        taskName: taskName,
                        docId: snapshot.data!.docs[index].id,
                        category: category,
                        color: color,
                        priority: priority,
                        icon: iconData,
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}