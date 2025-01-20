import 'package:flutter/material.dart';
import '../constants/responsive.dart';
import '../constants/app_text_styles.dart';
import '../widgets/universal_image.dart';

class ActiveCourseCard extends StatelessWidget {
  final String title;
  final String tag;
  final String imageUrl;
  final int completedModules;
  final int totalModules;

  const ActiveCourseCard({
    super.key,
    required this.title,
    required this.tag,
    required this.imageUrl,
    required this.completedModules,
    required this.totalModules,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();

    return Container(
      margin: EdgeInsets.only(right: responsive.buildMargin(context, 16)),
      width: responsive.buildWidth(context, 280),
      height: responsive.buildHeight(context, 330),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: UniversalImage(
              imagePath: imageUrl,
              height: responsive.buildHeight(context, 180),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(responsive.buildPadding(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.buildPadding(context, 12),
                      vertical: responsive.buildPadding(context, 6),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF1F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      tag,
                      style: AppTextStyles.medium12.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: responsive.buildHeight(context, 12)),
                  
                  // Title
                  Text(
                    title,
                    style: AppTextStyles.bold16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  
                  SizedBox(height: responsive.buildHeight(context, 16)),
                  
                  // Progress Bar and Text
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 
                                (completedModules / totalModules),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                     
                     
                    ],
                  ),
                   SizedBox(height: responsive.buildHeight(context, 8)),
                   Text(
                        '$completedModules/$totalModules Modules Complete!',
                        style: AppTextStyles.medium12.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}