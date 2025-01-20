import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/universal_image.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String instructor;
  final String courseName;
  final String duration;
  final VoidCallback onMoreTap;

  const OverviewCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.courseName,
    required this.duration,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.medium16.copyWith(
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey[600],
                  size: responsive.buildIconSize(context, 20),
                ),
                onPressed: onMoreTap,
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          Row(
            children: [
              ClipOval(
                child: UniversalImage(
                  imagePath: 'assets/images/yoga1.jpg',
                  height: responsive.buildHeight(context, 28),
                  width: responsive.buildWidth(context, 28),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: responsive.buildWidth(context, 8)),
              Text(
                instructor,
                style: AppTextStyles.medium14.copyWith(
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          Text(
            courseName,
            style: AppTextStyles.bold16.copyWith(
              color: Colors.black,
              height: 1.2,
            ),
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.buildPadding(context, 12),
              vertical: responsive.buildPadding(context, 8),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              duration,
              style: AppTextStyles.medium14.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 