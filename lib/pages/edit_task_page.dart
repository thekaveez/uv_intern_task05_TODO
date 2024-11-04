import 'package:flutter/material.dart';
import 'package:uv_intern_task05_todo/helper/helper_functions.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  String? _taskName;
  String? _docId;
  Color? _color;
  IconData? _icon;
  String? _category;
  String? _priority;

  @override
  void initState() {
    super.initState();
    // Initialize the controller without accessing context
    _taskController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accessing arguments passed from previous screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      _taskName = args['taskName'];
      _docId = args['docId'];
      _color = args['color'];
      _icon = args['icon'];
      _category = args['category'];
      _priority = args['priority'];

      // Set the task name in the controller
      _taskController.text = _taskName ?? '';
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Task Title Input
            Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white70),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Do Math Homework',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white70),
                  onPressed: () {},
                ),
              ],
            ),

            // Task Description
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white70),
                decoration: const InputDecoration(
                  hintText: 'Do chapter 2 to 5 for next week',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Task Time
            _buildListItem(
              icon: Icons.access_time,
              title: 'Task Time :',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Today At 16:45',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task Category
            _buildListItem(
              icon: Icons.bookmark_border,
              title: 'Task Category :',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _color?.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   Icon(
                      _icon,
                      color: _color,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      _category!,
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task Priority
            _buildListItem(
              icon: Icons.flag_outlined,
              title: 'Task Priority :',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _priority!,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Sub-Task
            _buildListItem(
              icon: Icons.account_tree_outlined,
              title: 'Sub - Task',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Add Sub-Task',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Delete Task
            InkWell(
              onTap: () {
                deleteTask(_docId!);
                Navigator.pop(context);
              },
              child: _buildListItem(
                icon: Icons.delete_outline,
                title: 'Delete Task',
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
            ),

            const Spacer(),

            // Edit Task Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Edit Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color iconColor = Colors.white70,
    Color textColor = Colors.white70,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(color: textColor),
        ),
        const Spacer(),
        if (trailing != null) trailing,
      ],
    );
  }
}