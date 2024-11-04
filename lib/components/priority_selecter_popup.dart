import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/my_button.dart';

class PrioritySelector extends StatefulWidget {
  final Function(int) onPrioritySelected;
  final int initialPriority;

  const PrioritySelector({
    Key? key,
    required this.onPrioritySelected,
    this.initialPriority = 1,
  }) : super(key: key);

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFF363636),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
              child: Text(
                'Task Priority',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 1.5,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final priority = index + 1;
                  final isSelected = priority == selectedPriority;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPriority = priority;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF7B61FF)
                            : const Color(0xFF282828),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              color: Colors.white.withOpacity(isSelected ? 1 : 0.5),
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              priority.toString(),
                              style: TextStyle(
                                color:
                                Colors.white.withOpacity(isSelected ? 1 : 0.5),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withOpacity(0.5),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Color(0xFF7B61FF)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyButton(
                        title: 'Save', 
                        color: 0xFF7B61FF,
                        onTap: () {
                          widget.onPrioritySelected(selectedPriority);
                          Navigator.pop(context);
                        },
                  )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<void> showPrioritySelectorDialog(
    BuildContext context, {
      required Function(int) onPrioritySelected,
      int initialPriority = 1,
    }) {
  return showDialog(
    context: context,
    builder: (context) => PrioritySelector(
      onPrioritySelected: onPrioritySelected,
      initialPriority: initialPriority,
    ),
  );
}