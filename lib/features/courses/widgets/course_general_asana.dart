import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/universal_image.dart';

class CourseGeneralAsana<T> extends StatelessWidget {
  final List<T> items;
  final String title;
  final bool isHorizontal;
  final double height;
  final EdgeInsets padding;
  final VoidCallback? onViewAll;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final String Function(T) getImageUrl;
  final String Function(T) getLevel;
  final Function(T) onItemTap;
  final int? itemCount;

  const CourseGeneralAsana({
    Key? key,
    required this.items,
    required this.title,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImageUrl,
    required this.getLevel,
    required this.onItemTap,
    this.isHorizontal = true,
    this.height = 280,
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
      onTap: () => onItemTap(item),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: UniversalImage(
                imagePath: getImageUrl(item),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle(item),
                    style: AppTextStyles.medium16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getSubtitle(item),
                    style: AppTextStyles.regular12.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          getLevel(item),
                          style: AppTextStyles.regular12.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard(T item) {
    return GestureDetector(
      onTap: () => onItemTap(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: UniversalImage(
                imagePath: getImageUrl(item),
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle(item),
                    style: AppTextStyles.medium14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getSubtitle(item),
                    style: AppTextStyles.regular12.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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