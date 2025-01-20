import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';

class MilestoneCard extends StatelessWidget {
  final String title;
  final String courseName;
  final String progress;
  final VoidCallback onMoreTap;

  const MilestoneCard({
    super.key,
    required this.title,
    required this.courseName,
    required this.progress,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      width: double.infinity,
      height: responsive.buildHeight(context, 129),
      padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bold20.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey[400],
                  size: responsive.buildIconSize(context, 20),
                ),
                onPressed: onMoreTap,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  courseName,
                  style: AppTextStyles.medium14.copyWith(
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                progress,
                style: AppTextStyles.medium12.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 8)),
          Stack(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 