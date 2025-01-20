import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/universal_image.dart';

class CourseProgressCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructor;
  final double progress;

  const CourseProgressCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.instructor,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
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
              imagePath: imageUrl,
              width: responsive.buildWidth(context, 80),
              height: responsive.buildHeight(context, 80),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: responsive.buildWidth(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  instructor,
                  style: AppTextStyles.regular12.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: responsive.buildHeight(context, 8)),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Text(
                  '${(progress * 100).toInt()}% Complete',
                  style: AppTextStyles.regular12.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 