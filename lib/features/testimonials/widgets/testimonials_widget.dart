import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

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

class TestimonialsWidget<T> extends StatelessWidget {
  final List<T> items;
  final String title;
  final bool isHorizontal;
  final double height;
  final EdgeInsets padding;
  final VoidCallback? onViewAll;
  final String Function(T) getName;
  final String Function(T) getRole;
  final String Function(T) getComment;
  final double Function(T) getRating;
  final String Function(T) getDate;
  final Function(T)? onItemTap;
  final int? itemCount;

  const TestimonialsWidget({
    Key? key,
    required this.items,
    required this.title,
    required this.getName,
    required this.getRole,
    required this.getComment,
    required this.getRating,
    required this.getDate,
    this.onItemTap,
    this.isHorizontal = true,
    this.height = 200,
    this.padding = const EdgeInsets.all(16),
    this.onViewAll,
    this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayItems = itemCount != null ? items.take(itemCount!).toList() : items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.bold20),
              if (onViewAll != null)
                GestureDetector(
                  onTap: onViewAll,
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: AppTextStyles.medium14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (isHorizontal)
          SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              itemCount: displayItems.length,
              itemBuilder: (context, index) => _buildCard(displayItems[index]),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: padding,
            itemCount: displayItems.length,
            itemBuilder: (context, index) => _buildCompactCard(displayItems[index]),
          ),
      ],
    );
  }

  Widget _buildCard(T item) {
    return GestureDetector(
      onTap: onItemTap != null ? () => onItemTap!(item) : null,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                    getName(item)[0].toUpperCase(),
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
                      Text(getName(item), style: AppTextStyles.medium14),
                      Text(
                        getRole(item),
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
                    Text(
                      getRating(item).toString(),
                      style: AppTextStyles.medium14,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                getComment(item),
                style: AppTextStyles.regular14,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              getDate(item),
              style: AppTextStyles.regular12.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard(T item) {
    return GestureDetector(
      onTap: onItemTap != null ? () => onItemTap!(item) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    getName(item)[0].toUpperCase(),
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
                      Text(getName(item), style: AppTextStyles.medium14),
                      Text(
                        getRole(item),
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
                    Text(
                      getRating(item).toString(),
                      style: AppTextStyles.medium14,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              getComment(item),
              style: AppTextStyles.regular14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              getDate(item),
              style: AppTextStyles.regular12.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 