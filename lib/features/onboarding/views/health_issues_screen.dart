import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class HealthIssuesScreen extends GetView<OnboardingController> {
  HealthIssuesScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final List<String> allHealthIssues = [
    'Heart Disease',
    'Asthma',
    'Sleep Apnea',
    'Epilepsy',
    'Bipolar Disorder',
    'Psoriasis',
    'Poor Immunity',
    'Diabetes',
    'Hypertension',
    'Arthritis',
    'Depression',
    'Anxiety',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: controller.previousStep,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Progress Bar
                    Row(
                      children: List.generate(
                        6,
                        (index) => Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: index <= 2 ? AppColors.primary : Colors.grey[300],
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    const Text(
                      'What Health Issues Are You Facing?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Search Box
                    TextField(
                      controller: searchController,
                      onChanged: (value) => controller.filterHealthIssues(value),
                      decoration: InputDecoration(
                        hintText: 'Start typing',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // List of Health Issues
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.filteredHealthIssues.length,
                  itemBuilder: (context, index) {
                    final issue = controller.filteredHealthIssues[index];
                    final isSelected = controller.healthIssues.contains(issue);
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        onTap: () => controller.toggleHealthIssue(issue),
                        title: Text(
                          issue,
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : Colors.black,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Section
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'We\'ll use this information to personalize your journey\nand recommend the best courses for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Continue',
                      onPressed: controller.canProceed() ? controller.nextStep : null,
                      backgroundColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 