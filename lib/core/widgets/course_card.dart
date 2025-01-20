import 'package:flutter/material.dart';
import 'package:purify/core/constants/app_colors.dart';
import '../constants/responsive.dart';
import '../constants/app_text_styles.dart';
import '../widgets/universal_image.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String level;
  final int sessions;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.level,
    required this.sessions,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return GestureDetector(
      onTap: onTap,
      child: Container(
      
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        width: responsive.buildWidth(context, 250),
        margin: EdgeInsets.only(right: responsive.buildMargin(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: UniversalImage(
                imagePath: imageUrl,
                height: responsive.buildHeight(context, 160),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: responsive.buildHeight(context, 12)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.buildPadding(context, 8),
              ),
              child: Text(
                title,
                style: AppTextStyles.medium16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: responsive.buildHeight(context, 8)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.buildPadding(context, 8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.buildPadding(context, 8),
                      vertical: responsive.buildPadding(context, 4),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      level,
                      style: AppTextStyles.regular12,
                    ),
                  ),
                  SizedBox(width: responsive.buildWidth(context, 8)),
                  Text(
                    '$sessions Sessions',
                    style: AppTextStyles.regular12.copyWith(
                      color: Colors.grey[600],
                    ),
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