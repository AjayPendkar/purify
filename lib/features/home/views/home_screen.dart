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
    return Container(
      height: ResponsiveFunctions().buildHeight(context, 300),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OverviewScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overview',
                  style: AppTextStyles.medium16.copyWith(
                    color: Colors.black,
                    fontSize: ResponsiveFunctions().buildFont(context, 16),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: ResponsiveFunctions().buildIconSize(context, 16),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: _buildUpcomingClassCard(context),
              ),
              SizedBox(width: ResponsiveFunctions().buildWidth(context, 16)),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildMilestonesCard(context),
                    SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
                    _buildActiveCoursesCard(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingClassCard(BuildContext context) {
    return Container(
     
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming',
                style: AppTextStyles.medium16.copyWith(
                  color: Colors.black87,
                  fontSize: ResponsiveFunctions().buildFont(context, 16),
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[600],
                size: 20,
              ),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
          Row(
            children: [
              ClipOval(
                child: UniversalImage(
                  imagePath: 'assets/images/yoga1.jpg',
                  height: 28,
                  width: 28,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: ResponsiveFunctions().buildWidth(context, 16)),
              Text(
                'Arvind Swamy',
                style: AppTextStyles.medium14.copyWith(
                  color: Colors.grey[800],
                  fontSize: ResponsiveFunctions().buildFont(context, 14),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 22)),
          Text(
            'Morning Yoga\nFlow',
            style: AppTextStyles.bold24.copyWith(
              color: Colors.black,
              height: 1.2,
              fontSize: ResponsiveFunctions().buildFont(context, 24),
            ),
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 22)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.chineseWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '00hr 32min 18sec',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Milestones',
                style: AppTextStyles.medium14.copyWith(
                  color: Colors.black,
                  fontSize: ResponsiveFunctions().buildFont(context, 14),
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[400],
                size: 12,
              ),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 10)),
          // Trophy icon
          const Icon(
            Icons.emoji_events_outlined,
            size: 24,
            color: Colors.black87,
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 10)),
          // Course title and progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Yoga for Stress Relief',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Align(
            alignment: Alignment.centerRight,
            child: Text(
              '01/23',
              style: AppTextStyles.medium10.copyWith(
                color: Colors.grey[600],
                fontSize: ResponsiveFunctions().buildFont(context, 10),
              ),
            ),
          ),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 12)),
          // Progress bar and count
          Stack(
            children: [
              // Background line
              Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              // Progress line
              Container(
                height: 2,
                width: 50, // Adjust width based on progress (e.g., 01/23)
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
          // Progress count
          
        ],
      ),
    );
  }

  Widget _buildActiveCoursesCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/9,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( 
                'Active Courses',
                style: AppTextStyles.medium14.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveFunctions().buildFont(context, 14),
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.grey[600]),
            ],
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
          Text('2', 
            style: AppTextStyles.medium20.copyWith(
              fontSize: ResponsiveFunctions().buildFont(context, 20),
            ),
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
      child: const Text(
        'Transform Your Life Through Purify',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
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
              const Text(
                'Active Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600]),
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

  Widget _buildCourseCard(BuildContext context,{bool showProgress = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.green,
            child: UniversalImage(
              imagePath: 'assets/images/yoga1.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
        const Text(
          'Pranayama for Stress Relief',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 4)),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Beginner',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(width: ResponsiveFunctions().buildWidth(context, 8)),
            Text(
              '32 Sessions',
              style: AppTextStyles.regular12.copyWith(
                color: Colors.grey[600],
                fontSize: ResponsiveFunctions().buildFont(context, 12),
              ),
            ),
          ],
        ),
        if (showProgress) ...[
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
          LinearProgressIndicator(
            value: 0.25,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(height: ResponsiveFunctions().buildHeight(context, 4)),
          Text(
            '25%',
            style: AppTextStyles.regular12.copyWith(
              color: Colors.grey[600],
              fontSize: ResponsiveFunctions().buildFont(context, 12),
            ),
          ),
        ],
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 8)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E4F4F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Enroll',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
        const Text(
          "Today's Activity",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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