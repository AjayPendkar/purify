import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purify/core/constants/app_colors.dart';
import 'package:purify/core/widgets/common_app_bar.dart';
import 'package:purify/features/courses/models/course_model.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/universal_image.dart';
import '../../../features/overview/models/course_model.dart';
import 'dart:async';
import '../../../core/widgets/base_screen.dart';
import '../../../core/widgets/course_card.dart';
import '../controllers/course_controller.dart';
import 'course_detail_screen.dart';

class CourseTabScreen extends StatefulWidget {
  final String userName;

  const CourseTabScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<CourseTabScreen> createState() => _CourseTabScreenState();
}

class _CourseTabScreenState extends State<CourseTabScreen> {
  final CourseController courseController = Get.find<CourseController>();
  String selectedCategory = 'All';
  int _currentPage = 0;
  final List<String> categories = [
    'All',
    'Top Picks',
    'Better Sleep',
    'Stress Relief'
  ];
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto scroll timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      setState(() {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
      });
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: GetBuilder<CourseController>(
        builder: (controller) => Scaffold(
          appBar: CommonAppBar(
            userName: widget.userName,
            onNotificationTap: () {
              // Handle notification tap
            },
            onSearchTap: () {
              // Handle search tap
            },
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                    ResponsiveFunctions().buildPadding(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 24)),
                    _buildCategories(controller),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 24)),
                    _buildFeaturedCourse(),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 24)),
                    _buildSection('Diabetes'),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 16)),
                    _buildCoursesList(controller),
                    SizedBox(
           
                        height: ResponsiveFunctions().buildHeight(context, 24)),
                    _buildSection('Section'),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 16)),
                    _buildCoursesList(controller),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 24)),
                    _buildSection('Section'),
                    SizedBox(
                        height: ResponsiveFunctions().buildHeight(context, 16)),
                    _buildCompactCoursesList(controller),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(CourseController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          bool isSelected = controller.selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 2),
            child: InkWell(
              onTap: () => controller.setCategory(category),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2E4F4F)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedCourse() {
    return GetBuilder<CourseController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final featuredAsanas = controller.getFilteredAsanas().take(5).toList();

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: featuredAsanas.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final asana = featuredAsanas[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          UniversalImage(
                            imagePath: asana.photoLink,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  asana.asanaName,
                                  style: AppTextStyles.bold24
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  asana.benefits,
                                  style: AppTextStyles.regular16
                                      .copyWith(color: Colors.white70),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Explore Now',
                                    style: TextStyle(color: Color(0xFF2E4F4F)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredAsanas.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF2E4F4F)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bold20,
        ),
        Icon(Icons.arrow_forward, color: Colors.grey[600]),
      ],
    );
  }

  Widget _buildCoursesList(CourseController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading data: ${controller.error}',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.retryLoading(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final asanas = controller.getFilteredAsanas();

    if (asanas.isEmpty) {
      return const Center(
        child: Text('No asanas found'),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: asanas.length,
        itemBuilder: (context, index) {
          final asana = asanas[index];
          return CourseCard(
            title: asana.asanaName,
            imageUrl: asana.photoLink,
            level: asana.difficultyLevel,
            sessions: 1,
            onTap: () => Get.to(() => CourseDetailScreen(asana: asana)),
          );
        },
      ),
    );
  }

  Widget _buildCompactCoursesList(CourseController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final asanas = controller.getFilteredAsanas();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final asana = asanas[index];
        return GestureDetector(
          onTap: () => Get.to(() => CourseDetailScreen(asana: asana)),
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: UniversalImage(
                    imagePath: asana.photoLink,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        asana.asanaName,
                        style: AppTextStyles.medium14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        asana.benefits,
                        style: AppTextStyles.regular12.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
