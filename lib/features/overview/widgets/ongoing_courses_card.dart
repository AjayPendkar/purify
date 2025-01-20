import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../features/overview/views/ongoing_courses_screen.dart';

class OngoingCoursesCard extends StatelessWidget {
  final int count;
  final VoidCallback onMoreTap;

  const OngoingCoursesCard({
    super.key,
    required this.count,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return GestureDetector(
      onTap: onMoreTap,
      child: Container(
        height: responsive.buildHeight(context, 80),
        padding: EdgeInsets.all(responsive.buildPadding(context, 12)),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Courses',
                  style: AppTextStyles.medium14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.grey[600]),
              ],
            ),
            Text(
              count.toString(),
              style: AppTextStyles.medium20,
            ),
          ],
        ),
      ),
    );
  }
} 