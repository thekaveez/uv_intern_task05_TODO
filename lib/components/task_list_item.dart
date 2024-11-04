import 'package:flutter/material.dart';
import 'package:uv_intern_task05_todo/components/add_task_popup.dart';

class TaskListItem extends StatefulWidget {
  final String taskName;
  final String docId;
  final Color color;
  final IconData icon;
  final String category;
  final String priority;

  const TaskListItem({
    Key? key,
    required this.taskName,
    required this.docId,
    required this.color,
    required this.icon,
    required this.category,
    required this.priority,
  }) : super(key: key);

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  String? selectedTask;
  final updateTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTask = widget.taskName;
            updateTaskController.text = selectedTask!;
          });
          addTaskPopup(
            context,
            updateTaskController,
            isUpdate: true,
            docId: widget.docId,
          );
        },
        onLongPress: () {
          Navigator.pushNamed(context, '/editTask', arguments: {
            'taskName': widget.taskName,
            'docId': widget.docId,
            'color': widget.color,
            'icon': widget.icon,
            'category': widget.category,
            'priority': widget.priority,
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFF363636),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<String>(
                  value: widget.taskName,
                  groupValue: selectedTask,
                  activeColor: Colors.white,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTask = value;
                      updateTaskController.text = selectedTask!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.taskName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'Today at 10:00 AM',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                color: widget.color,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      widget.icon,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.category,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color(0xFF7B61FF),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: Color(0xFF7B61FF),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.priority,
                                      style: const TextStyle(
                                        color: Color(0xFF7B61FF),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
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
      ),
    );
  }
}