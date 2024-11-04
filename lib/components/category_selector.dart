import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uv_intern_task05_todo/components/my_button.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategorySelector extends StatelessWidget {
  final Function(Category) onCategorySelected;

  CategorySelector({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  final List<Category> categories = [
    Category(
      name: 'Grocery',
      icon: Icons.shopping_basket_outlined,
      color: const Color(0xFFB4F3AA),
    ),
    Category(
      name: 'Work',
      icon: Icons.work_outline,
      color: const Color(0xFFFFB7B7),
    ),
    Category(
      name: 'Sport',
      icon: Icons.fitness_center_outlined,
      color: const Color(0xFF98F6FF),
    ),
    Category(
      name: 'Design',
      icon: Icons.design_services_outlined,
      color: const Color(0xFF9EFFD6),
    ),
    Category(
      name: 'University',
      icon: Icons.school_outlined,
      color: const Color(0xFFB4AAFF),
    ),
    Category(
      name: 'Social',
      icon: Icons.campaign_outlined,
      color: const Color(0xFFFF9EF5),
    ),
    Category(
      name: 'Music',
      icon: Icons.music_note_outlined,
      color: const Color(0xFFE49EFF),
    ),
    Category(
      name: 'Health',
      icon: Icons.favorite_outline,
      color: const Color(0xFF9EFFC1),
    ),
    Category(
      name: 'Movie',
      icon: Icons.movie_outlined,
      color: const Color(0xFF9EC6FF),
    ),
    Category(
      name: 'Home',
      icon: Icons.home_outlined,
      color: const Color(0xFFFFD79E),
    ),
    Category(
      name: 'Create New',
      icon: Icons.add,
      color: const Color(0xFF9EFFD6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFF363636),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            child: Text(
              'Choose Category',
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
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    onCategorySelected(category);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: category.color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              category.icon,
                              color: Color.fromARGB(
                                category.color.alpha,
                                (category.color.red * 0.7).toInt(),
                                (category.color.green * 0.7).toInt(),
                                (category.color.blue * 0.7).toInt(),
                              ),
                              size: 42,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
            child: MyButton(title: 'Add Category', color: 0xFF7B61FF, onTap: () {Navigator.pop(context);}, isFullWidth: true,)
          ),
        ],
      ),
    );
  }
}

// Helper function to show the dialog
Future<void> showCategorySelector(
    BuildContext context, {
      required Function(Category) onCategorySelected,
    }) {
  return showDialog(
    context: context,
    builder: (context) => CategorySelector(
      onCategorySelected: onCategorySelected,
    ),
  );
}