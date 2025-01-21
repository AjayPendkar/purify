import 'package:flutter/material.dart';
import 'package:purify/core/constants/app_colors.dart';
import 'package:purify/features/overview/views/overview_screen.dart';
import '../../../core/widgets/active_course_card.dart';
import '../../../screens/active_courses_screen.dart';
import '../../../core/widgets/today_activity_card.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/universal_image.dart';
import '../../../features/courses/views/course_tab_screen.dart';
import '../../../features/home/models/activity_model.dart';
import '../../../features/home/widgets/today_activity_section.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/base_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  
  const HomeScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = [
      ActivityModel(
        time: '5:00 AM',
        title: 'Wake up',
        description: 'Start your day early with a calm mindset.',
        period: 'Morning',
      ),
      ActivityModel(
        time: '5:30 AM',
        title: 'Meditation',
        description: 'Begin with 10 minutes of mindfulness.',
        period: 'Morning',
      ),
      ActivityModel(
        time: '6:00 AM',
        title: 'Yoga',
        description: 'Morning yoga flow for energy.',
        period: 'Morning',
      ),
    ];

    return BaseScreen(
      child: Scaffold(
        appBar: CommonAppBar(
          userName: userName,
          onNotificationTap: () {},
          onSearchTap: () {},
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveFunctions().buildPadding(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewSection(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildTransformSection(context),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                TodayActivitySection(activities: activities),
                SizedBox(height: ResponsiveFunctions().buildHeight(context, 24)),
                _buildActiveCourses(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Column(
      children: [
        // Overview header
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OverviewScreen()),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Overview', style: AppTextStyles.medium16),
              Icon(Icons.arrow_forward_ios, color: AppColors.greyDark, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Cards row
        SizedBox(
          height: ResponsiveFunctions().buildHeight(context, 300), // Fixed height for the row
          child: Row(
            children: [
              // Left card (Upcoming)
              Expanded(
                child: _buildUpcomingClassCard(context),
              ),
              const SizedBox(width: 16),
              // Right column (Milestones & Active Courses)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                    flex: 2,
                      child: _buildMilestonesCard(context),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      flex: 1,
                      child: _buildActiveCoursesCard(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingClassCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
     decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Text('Upcoming', style: AppTextStyles.medium16),
              Icon(Icons.more_vert, color: AppColors.greyDark, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ClipOval(
                child: UniversalImage(
                  imagePath: 'assets/images/yoga1.jpg',
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Text('Arvind Swamy', style: AppTextStyles.medium14),
            ],
          ),
          const Spacer(),
          Text('Morning Yoga\nFlow', 
            style: AppTextStyles.bold24.copyWith(height: 1.2),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.chineseWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('00hr 32min 18sec', style: AppTextStyles.medium14),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Milestones', style: AppTextStyles.medium14),
              Icon(Icons.more_horiz, color: AppColors.greyDark, size: 24),
            ],
          ),
          const SizedBox(height: 24),
          const Icon(Icons.emoji_events_outlined, 
            size: 28,
            color: Colors.black87
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yoga for Stress Relief',
                  style: AppTextStyles.regular12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: AppColors.greyLight.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                    minHeight: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '01/23',
                    style: AppTextStyles.regular12.copyWith(
                      color: AppColors.greyDark
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCoursesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ongoing Courses', style: AppTextStyles.medium14),
              Icon(Icons.more_horiz, color: AppColors.greyDark, size: 24),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('2', style: AppTextStyles.bold24),
              Icon(Icons.arrow_forward_ios, 
                color: AppColors.greyDark, 
                size: 20
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransformSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.chineseWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Transform Your Life Through Purify',
        style: AppTextStyles.medium16,
      ),
    );
  }

  Widget _buildFeaturedCourses(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Courses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCourseCard(context)),
            SizedBox(width: ResponsiveFunctions().buildWidth(context, 16)),
            Expanded(child: _buildCourseCard(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveCourses(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ActiveCoursesScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Courses',
                style: AppTextStyles.medium18,
              ),
              Icon(Icons.chevron_right, color: AppColors.greyDark),
            ],
          ),
        ),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
        SizedBox(
          height: 330,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Example count, adjust as needed
            itemBuilder: (context, index) {
              return ActiveCourseCard(
                tag: 'Beginner',
                title: 'Pranayama for Stress Relief',
                completedModules: 1,
                totalModules: 23,
                imageUrl: 'assets/images/yoga1.jpg',
                
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(BuildContext context, {bool showProgress = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: AppColors.green,
            child: UniversalImage(
              imagePath: 'assets/images/yoga1.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Pranayama for Stress Relief', style: AppTextStyles.medium16),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Beginner', style: AppTextStyles.regular12),
            ),
            const SizedBox(width: 8),
            Text('32 Sessions', style: AppTextStyles.regular12),
          ],
        ),
        if (showProgress) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.25,
            backgroundColor: AppColors.greyLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
          ),
          const SizedBox(height: 4),
          Text('25%', style: AppTextStyles.regular12),
        ],
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Enroll', style: AppTextStyles.medium16.copyWith(color: AppColors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF2E4F4F),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Learn'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildTodayCourses(BuildContext context) {
    final List<Map<String, String>> todayActivities = [
      {
        'number': '01',
        'title': 'Pranayama for Stress Relief',
        'duration': '15min',
        'level': 'Intermediate',
        'trainerName': 'Arvind Swami',
        'trainerRole': 'Professional trainer',
        'imageUrl': 'assets/images/homeYogaPose.svg',
      },
      {
        'number': '02', 
        'title': 'Morning Flow Yoga',
        'duration': '20min',
        'level': 'Beginner',
        'trainerName': 'Sarah Johnson',
        'trainerRole': 'Yoga Instructor',
        'imageUrl': 'assets/images/homeYogaPose.svg',
      },
      {
        'number': '03',
        'title': 'Power Vinyasa Flow',
        'duration': '30min', 
        'level': 'Advanced',
        'trainerName': 'Michael Chen',
        'trainerRole': 'Senior Instructor',
        'imageUrl': 'assets/images/homeYogaPose.svg',
      },
      {
        'number': '04',
        'title': 'Meditation Basics',
        'duration': '10min',
        'level': 'Beginner',
        'trainerName': 'Emma Wilson',
        'trainerRole': 'Meditation Guide',
        'imageUrl': 'assets/images/homeYogaPose.svg',
      },
      {
        'number': '05',
        'title': 'Restorative Yoga',
        'duration': '25min',
        'level': 'Intermediate',
        'trainerName': 'David Kumar',
        'trainerRole': 'Yoga Therapist',
        'imageUrl': 'assets/images/homeYogaPose.svg',
      }
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Activity", style: AppTextStyles.medium18),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
        SizedBox(
          height: ResponsiveFunctions().buildHeight(context, 400), // Fixed height container
          child: ListView.builder(
            itemCount: todayActivities.length,
            itemBuilder: (context, index) {
              final activity = todayActivities[index];
              return TodayActivityCard(
                number: activity['number']!,
                title: activity['title']!,
                duration: activity['duration']!,
                level: activity['level']!,
                trainerName: activity['trainerName']!,
                trainerRole: activity['trainerRole']!,
                imageUrl: activity['imageUrl']!,
                onStart: () {
                  // Handle start button tap
                },
              );
            },
          ),
        ),
      ],
    );
  }
}