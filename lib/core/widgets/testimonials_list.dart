import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class TestimonialItem {
  final String name;
  final String role;
  final String comment;
  final double rating;
  final String date;

  TestimonialItem({
    required this.name,
    required this.role,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

class TestimonialsList extends StatelessWidget {
  final List<TestimonialItem> items;

  const TestimonialsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      item.name[0].toUpperCase(),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: AppTextStyles.medium14),
                        Text(
                          item.role,
                          style: AppTextStyles.regular12.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(item.rating.toString(), style: AppTextStyles.medium14),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(item.comment, style: AppTextStyles.regular14),
              const SizedBox(height: 8),
              Text(
                item.date,
                style: AppTextStyles.regular12.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 