import 'package:flutter/material.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';

class WeeklyStreak extends StatelessWidget {
  final List<bool> streakDays;
  final VoidCallback onMoreTap;

  const WeeklyStreak({
    super.key,
    required this.streakDays,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Streaks',
                style: AppTextStyles.medium14.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey[600],
                ),
                onPressed: onMoreTap,
              ),
            ],
          ),
          SizedBox(height: responsive.buildHeight(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return Icon(
                Icons.spa,
                color: streakDays[index] ? const Color(0xFF2E4F4F) : Colors.grey[400],
                size: responsive.buildIconSize(context, 24),
              );
            }),
          ),
        ],
      ),
    );
  }
} 