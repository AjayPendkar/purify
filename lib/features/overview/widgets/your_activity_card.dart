import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';

class YourActivityCard extends StatelessWidget {
  final String duration;
  final VoidCallback? onMoreTap;

  const YourActivityCard({
    super.key,
    required this.duration,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Your Activity',
                  style: AppTextStyles.bold20.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
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
          SizedBox(height: responsive.buildHeight(context, 12)),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: responsive.buildIconSize(context, 20),
                color: Colors.grey[600],
              ),
              SizedBox(width: responsive.buildWidth(context, 8)),
              Expanded(
                child: Text(
                  'This Week',
                  style: AppTextStyles.medium16.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 20)),
          Text(
            'Time Spent on courses.',
            style: AppTextStyles.medium20.copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: responsive.buildHeight(context, 12)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.buildPadding(context, 16),
                vertical: responsive.buildPadding(context, 12),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                duration,
                style: AppTextStyles.bold24.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 