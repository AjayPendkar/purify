import 'package:flutter/material.dart';
import '../constants/responsive.dart';
import '../widgets/universal_image.dart';

class TodayActivityCard extends StatelessWidget {
  final String number;
  final String title;
  final String duration;
  final String level;
  final String trainerName;
  final String trainerRole;
  final String imageUrl;
  final VoidCallback onStart;

  const TodayActivityCard({
    super.key,
    required this.number,
    required this.title,
    required this.duration,
    required this.level,
    required this.trainerName,
    required this.trainerRole,
    required this.imageUrl,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      margin: EdgeInsets.only(
        bottom: responsive.buildMargin(context, 16),
      ),
      height: responsive.buildHeight(context, 139), // Fixed height
      padding: EdgeInsets.all(
        responsive.buildPadding(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#$number',
                      style: TextStyle(
                        fontSize: responsive.buildFont(context, 14),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: responsive.buildHeight(context, 4)),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: responsive.buildFont(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: responsive.buildHeight(context, 4)),
                    Row(
                      children: [
                        Text(
                          '$duration • ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: responsive.buildFont(context, 12),
                          ),
                        ),
                        Text(
                          level,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: responsive.buildFont(context, 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainerName,
                      style: TextStyle(
                        fontSize: responsive.buildFont(context, 14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      trainerRole,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: responsive.buildFont(context, 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: UniversalImage(
                  imagePath: imageUrl,
                  width: responsive.buildWidth(context, 80),
                  height: responsive.buildHeight(context, 60),
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E4F4F),
                  minimumSize: Size(
                    responsive.buildWidth(context, 80),
                    responsive.buildHeight(context, 32),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.buildFont(context, 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 