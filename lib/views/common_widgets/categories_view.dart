import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
    required this.imagePath,
    required this.catName,
  });

  final String imagePath;
  final String catName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(imagePath),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            catName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
