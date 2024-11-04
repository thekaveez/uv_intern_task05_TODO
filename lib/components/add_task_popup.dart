import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/category_selector.dart';
import 'package:uv_intern_task05_todo/components/priority_selecter_popup.dart';
import 'package:uv_intern_task05_todo/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addTaskPopup(BuildContext context, TextEditingController controller, {required bool isUpdate, String? docId} ) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(insetPadding: const EdgeInsets.all(0),
        backgroundColor: const Color(0xFF363636),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // No rounded corners
        ),
        child: SizedBox(
          width: double.infinity,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
                child: Text(
                  'Add Task',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        hintText: 'Task Name',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        fillColor: Colors.transparent,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xff979797),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color(0xff979797)
                            )
                        )
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Add your task handling logic here
                        Navigator.pop(context); // Add action
                      },
                      icon: Icon(Icons.timer_outlined, color: Colors.white70, size: 28,),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Add action
                        showCategorySelector(context, onCategorySelected: (category) {
                          updateTaskCategory(category.name.toString(), category.color.toString(), category.icon.toString(), docId!);
                          print('Category selected ${category.name}');
                        });
                      },
                      icon: Image(image: Image.asset('assets/tag_icon.png').image, width: 32, height: 32,),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showPrioritySelectorDialog(context, onPrioritySelected: (priority) {
                          updateTaskPriority(priority.toString(), docId!);
                          print('Priority selected $priority');
                        });// Add action
                      },
                      icon: const Icon(Icons.flag_outlined, color: Colors.white70, size: 28,),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (isUpdate && docId != null){
                          updateTask(controller, context, docId);
                        } else {
                          postTask(controller, context);
                        }
                      },
                      icon: const Icon(Icons.send_outlined, color: Color(0xFF7B61FF), size: 28,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}