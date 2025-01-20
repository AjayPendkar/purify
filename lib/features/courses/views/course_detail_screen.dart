import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/features/testimonials/widgets/testimonials_widget.dart' as tw;
import 'package:purify/features/courses/controllers/course_controller.dart';
import 'package:purify/features/courses/widgets/course_general_asana.dart';
import 'package:purify/features/testimonials/widgets/testimonials_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/base_screen.dart';
import '../../../core/widgets/universal_image.dart';
import '../models/course_model.dart';
import 'package:purify/features/testimonials/widgets/testimonials_widget.dart'
    as tw;
// Then use it as: tw.TestimonialItem

class CourseDetailScreen extends StatelessWidget {
  final AsanaModel asana;
  final List<tw.TestimonialItem> testimonials = [
    tw.TestimonialItem(
      name: 'Alex K.',
      role: 'Software Engineer',
      comment:
          'This course has been life-changing! The yoga practices are easy to follow, and I\'ve noticed significant improvements in my energy levels and blood sugar control.',
      rating: 4.9,
      date: 'Jan 20, 2024',
    ),
    tw.TestimonialItem(
      name: 'Sarah M.',
      role: 'Teacher',
      comment:
          'Amazing course! The instructors are very knowledgeable and the poses are well explained. Highly recommended for beginners.',
      rating: 4.8,
      date: 'Jan 18, 2024',
    ),
    tw.TestimonialItem(
      name: 'John D.',
      role: 'Business Analyst',
      comment:
          'Great structure and progression. I can already feel the difference in my flexibility and stress levels.',
      rating: 4.7,
      date: 'Jan 15, 2024',
    ),
  ];

  CourseDetailScreen({
    Key? key,
    required this.asana,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Course Outline',
            style: AppTextStyles.medium16.copyWith(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Image with Rating
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: UniversalImage(
                        imagePath: asana.photoLink,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.5/5 (23+)',
                              style: AppTextStyles.medium12.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Description
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yoga for Diabetes Management',
                            style: AppTextStyles.bold20,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This Course helps manage diabetes through yoga, pranayama, and holistic remedies with personalized guidance and progress tracking.',
                            style: AppTextStyles.regular14.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Key Benefits
                    Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.all(16),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Key Benefits', style: AppTextStyles.bold16),
                          const SizedBox(height: 16),
                          Container(
                            height: 110,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildBenefitItem(Icons.medical_services,
                                    'Blood Sugar\nRegulate', context),
                                _buildBenefitItem(Icons.favorite,
                                    'Heart Rate\nRegulate', context),
                                _buildBenefitItem(Icons.accessibility,
                                    'Body Weight\nRegulate', context),
                                _buildBenefitItem(Icons.psychology,
                                    'Mental\nRegulate', context),
                                _buildBenefitItem(Icons.favorite,
                                    'Heart Rate\nRegulate', context),
                                _buildBenefitItem(Icons.accessibility,
                                    'Body Weight\nRegulate', context),
                                _buildBenefitItem(Icons.psychology,
                                    'Mental\nRegulate', context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Course Highlights
                    Text('Course Highlights', style: AppTextStyles.bold16),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildHighlightItem(
                            '50 Targeted poses',
                          ),
                          _buildHighlightItem(
                            '5 Pranayama Techniques',
                          ),
                          _buildHighlightItem(
                            '3 Acupressure points',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildHighlightItem(
                                  '20+ daily activities',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildHighlightItem(
                                  '4 weeks',
                                ),
                              ),
                            ],
                          ),
                          _buildHighlightItem(
                            'Beginner',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Daily Schedule Section
                    Text('Your Daily Wellness Plan',
                        style: AppTextStyles.bold16),
                    const SizedBox(height: 8),
                    Text(
                      'The more activities you follow, the sooner you\'ll be healthy',
                      style: AppTextStyles.regular12
                          .copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildScheduleItem(
                            'Wakeup',
                            'Notification at 5 AM',
                          ),
                          _buildScheduleItem(
                            'Morning Yoga',
                            '30 mins Yoga Session (Before 7 AM)',
                          ),
                          _buildScheduleItem(
                            'Breakfast',
                            'Light Protein/Fiber Rich Meal (Before 8 AM)',
                          ),
                          _buildScheduleItem(
                            'Acupressure',
                            '5 mins for digestion and stress relief',
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Activate to Unlock Your Plan',
                                style: AppTextStyles.medium14.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              CourseGeneralAsana<AsanaModel>(
                title: 'General Asanas',
                items: Get.find<CourseController>().asanas,
                getTitle: (asana) => asana.asanaName,
                getSubtitle: (asana) => asana.benefits,
                getImageUrl: (asana) => asana.photoLink,
                getLevel: (asana) => asana.difficultyLevel,
                onItemTap: (asana) =>
                    Get.to(() => CourseDetailScreen(asana: asana)),
                isHorizontal: true,
                itemCount: 4,
              ),

              SizedBox(height: 24),
              tw.TestimonialsWidget<tw.TestimonialItem>(
                title: 'Reviews and Testimonials',
                items: testimonials,
                getName: (item) => item.name,
                getRole: (item) => item.role,
                getComment: (item) => item.comment,
                getRating: (item) => item.rating,
                getDate: (item) => item.date,
                itemCount: 5, // Optional: show only 5 items
                onViewAll: () {
                  // Handle view all tap
                },
                isHorizontal: true,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Start Practice',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text, BuildContext context) {
    return Container(
      width: 85,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            _getIconForText(text),
            size: 24,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: AppTextStyles.regular14.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForText(String text) {
    switch (text) {
      case '50 Targeted poses':
        return Icons.self_improvement;
      case '5 Pranayama Techniques':
        return Icons.air;
      case '3 Acupressure points':
        return Icons.touch_app;
      case '20+ daily activities':
        return Icons.calendar_today;
      case '4 weeks':
        return Icons.timer;
      case 'Beginner':
        return Icons.trending_up;
      default:
        return Icons.circle;
    }
  }

  Widget _buildScheduleItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForSchedule(title),
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium14,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.regular12.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForSchedule(String title) {
    switch (title) {
      case 'Wakeup':
        return Icons.wb_sunny;
      case 'Morning Yoga':
        return Icons.self_improvement;
      case 'Breakfast':
        return Icons.restaurant;
      case 'Acupressure':
        return Icons.touch_app;
      default:
        return Icons.circle;
    }
  }
}
