import 'package:flutter/material.dart';
import 'package:purify/core/widgets/base_screen.dart';
import 'package:purify/features/overview/widgets/activity_chart.dart';
import 'package:purify/features/overview/widgets/course_progress_card.dart';
import 'package:purify/features/overview/widgets/ongoing_courses_card.dart';
import 'package:purify/features/overview/widgets/weekly_streak.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/overview_card.dart';
import '../widgets/milestone_card.dart';
import '../widgets/your_activity_card.dart';
import '../models/course_model.dart';
import '../views/ongoing_courses_screen.dart';


class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Overview',
            style: AppTextStyles.medium16.copyWith(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveFunctions().buildPadding(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopSection(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildActivityChart(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildActivityAndMilestones(context),
                // SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                // _buildCompletedCourses(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildWeeklyStreak(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildCourseProgress(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: OverviewCard(
            title: 'Upcoming',
            instructor: 'Arvind Swamy', 
            courseName: 'Morning Yoga\nFlow',
            duration: '00hr 32min 18sec',
            onMoreTap: () {},
          ),
        ),
        SizedBox(width: ResponsiveFunctions().buildWidth(context, 16)),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MilestoneCard(
                title: 'Milestones',
                courseName: 'Yoga for Stress Relief',
                progress: '01/23',
                onMoreTap: () {},
              ),
              SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
              OngoingCoursesCard(
                count: CourseModel.sampleCourses.length,
                onMoreTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OngoingCoursesScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityChart(BuildContext context) {
    return ActivityChart(
      weekData: [12, 8, 15, 5, 10, 18, 14],  // Daily asanas
      monthData: [45, 52, 38, 48],  // Weekly asanas
      yearData: [180, 220, 250, 270, 240, 260],  // Bi-monthly asanas
      selectedDay: 5,
    );
  }

  Widget _buildActivityAndMilestones(BuildContext context) {
    return Container(
      height: ResponsiveFunctions().buildHeight(context, 270),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                MilestoneCard(
                  title: 'Milestones',
                  courseName: 'Yoga for Stress Relief',
                  progress: '01/23',
                  onMoreTap: () {},
                ),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
                _buildCompletedCourses(context),
              ],
            ),
          ),
          SizedBox(width: ResponsiveFunctions().buildWidth(context, 8)),
          Expanded(
            child: YourActivityCard(
              duration: '05hr 20min 18sec',
              onMoreTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCourses(BuildContext context) {
    final responsive = ResponsiveFunctions();
    
    return Container(
      width: double.infinity,
      height: responsive.buildHeight(context, 129),
      padding: EdgeInsets.all(responsive.buildPadding(context, 24)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completed courses',
                style: AppTextStyles.boldHeading12.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[400],
                size: responsive.buildIconSize(context, 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2',
                style: AppTextStyles.bold32.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[600],
                size: responsive.buildIconSize(context, 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak(BuildContext context) {
    return WeeklyStreak(
      streakDays: [true, true, true, true, true, false, false],
      onMoreTap: () {},
    );
  }

  Widget _buildCourseProgress(BuildContext context) {
    return Column(
      children: [
        CourseProgressCard(
          imageUrl: 'assets/images/yoga1.jpg',
          title: 'Strength Within: Power Yoga for Beginners',
          instructor: 'Sarah Matthews',
          progress: 0.01,
        ),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
        CourseProgressCard(
          imageUrl: 'assets/images/yoga2.jpg',
          title: 'Stress Less: Acupressure for Relaxation',
          instructor: 'Dr. Elise Chen',
          progress: 0.01,
        ),
      ],
    );
  }
} 