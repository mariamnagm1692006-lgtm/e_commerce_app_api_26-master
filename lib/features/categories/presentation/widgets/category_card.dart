import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final int? id;
  final String? name;
  final String? imageUrl;

  const CategoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80, // Adjust size as needed
            height: 80, // Adjust size as needed
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Placeholder background
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl??""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name??"error",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
