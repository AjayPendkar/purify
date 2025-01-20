import 'package:flutter/material.dart';
import 'package:purify/features/overview/widgets/course_progress_card.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/course_model.dart';

class OngoingCoursesScreen extends StatelessWidget {
  const OngoingCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ongoing Courses',
          style: AppTextStyles.medium16.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveFunctions().buildPadding(context, 16)),
        child: ListView.separated(
          itemCount: CourseModel.sampleCourses.length,
          separatorBuilder: (context, index) => SizedBox(
            height: ResponsiveFunctions().buildHeight(context, 16),
          ),
          itemBuilder: (context, index) {
            final course = CourseModel.sampleCourses[index];
            return CourseProgressCard(
              imageUrl: course.imageUrl,
              title: course.title,
              instructor: course.instructor,
              progress: course.progress,
            );
          },
        ),
      ),
    );
  }
} 