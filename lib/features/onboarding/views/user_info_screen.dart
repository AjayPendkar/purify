import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/core/constants/app_colors.dart';
import 'package:purify/core/constants/app_text_styles.dart';
import 'package:purify/core/constants/responsive.dart';
import 'package:purify/core/widgets/base_screen.dart';
import 'package:purify/core/widgets/custom_button.dart';
import 'package:purify/core/widgets/universal_image.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/info_dialog.dart';

class UserInfoScreen extends GetView<OnboardingController> {
const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        // Show loading only during initial check
        if (controller.isChecking) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BaseScreen(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Fixed Top Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // Progress Bar
                        _buildStepper(context),
                      ],
                    ),
                  ),
          
                  // Middle Section (Scrollable)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            // Title Row with Back Button
                            Row(
                              children: [
                                if (controller.currentStep > 0)
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back, size: 24),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: controller.previousStep,
                                  ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    controller.currentStep == 0 
                                        ? "Let's Get to Know You."
                                        : controller.currentStep == 1
                                            ? "What Health Issues Are You Facing?"
                                            : "Rate Your Health Issues",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            if (controller.currentStep == 0) ...[
                              // Name TextField
                               Text("Select Names "),
                                const SizedBox(height: 8),
                              _buildPersonalInfo(context),
                              
                              const SizedBox(height: 24),
                              Text("Select Gender "),
                               const SizedBox(height: 8),
                              // Gender Options
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: _buildGenderOption('Male', context),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: _buildGenderOption('Female', context),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: _buildGenderOption('Prefer not to say', context),
                                  ),
                                ],
                              ),
                            ] else if (controller.currentStep == 1) ...[
                              // Health Issues Section with Fixed Search
                              Column(
                                children: [
                                  // Fixed Search Bar
                                  TextField(
                                    controller: controller.nameController,
                                    onChanged: controller.filterHealthIssues,
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
                                  const SizedBox(height: 16),
                                  
                                  // Scrollable List
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.4,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
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
                                  const SizedBox(height: 24),
          
                                  // Duration section
                                  
                                ],
                              ),
                            ] else if (controller.currentStep == 2) ...[
                              // Health Issues Severity Section
                            
                            
                            
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Selected Health Issues List
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.healthIssues.length,
                                    itemBuilder: (context, index) {
                                      final issue = controller.healthIssues[index];
                                      final severity = controller.getHealthIssueSeverity(issue);
                                      final duration = controller.getIssueDuration(issue);
                                      
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 12),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.grey[200]!),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    issue,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons.chevron_left),
                                                      onPressed: () => controller.toggleSeverity(issue),
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      severity,
                                                      style: TextStyle(
                                                        color: severity == 'Mild' 
                                                            ? Colors.green 
                                                            : severity == 'Moderate' 
                                                                ? Colors.orange 
                                                                : Colors.red,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(Icons.chevron_right),
                                                      onPressed: () => controller.toggleSeverity(issue),
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              
                                            ),
                                            const SizedBox(height: 16),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'How long have you been experiencing this issue?',
                                                  style: AppTextStyles.regular12.copyWith(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: SliderTheme(
                                                        data: SliderThemeData(
                                                          activeTrackColor: AppColors.primary,
                                                          inactiveTrackColor: Colors.grey[200],
                                                          thumbColor: AppColors.primary,
                                                          overlayColor: AppColors.primary.withOpacity(0.2),
                                                        ),
                                                        child: Slider(
                                                          min: 0,
                                                          max: 24,
                                                          divisions: 24,
                                                          value: duration,
                                                          onChanged: (value) => controller.updateIssueDuration(issue, value),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      '${duration.round()} months',
                                                      style: AppTextStyles.regular12.copyWith(
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  
                                  // Severity Explanation Box
                                  Container(
                                    margin: const EdgeInsets.only(top: 24),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Mild - It\'s manageable with minimal discomfort.',
                                          style: TextStyle(height: 1.5),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Moderate - It affects my daily routine sometimes.',
                                          style: TextStyle(height: 1.5),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Severe - It significantly impacts my daily life.',
                                          style: TextStyle(height: 1.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ] else if (controller.currentStep == 3) ...[
                              // Final Screen
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 5),
                                  // Doctor Image
                                  UniversalImage(
                                    imagePath: 'assets/images/onboard5.svg',
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 0),
                                  // Title
                                  const Text(
                                    'Your Wellness Plan Awaits!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  // Subtitle
                                  const Text(
                                    'Let\'s get you your\npersonalized program!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  // Description
                                  Text(
                                    'Sign up so we can save your progress',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  // Phone Button
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.grey.withOpacity(0.1),
                                  //         blurRadius: 10,
                                  //         offset: const Offset(0, 2),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child: Material(
                                  //     color: Colors.transparent,
                                  //     child: InkWell(
                                  //       onTap: () {
                                  //         // Navigate to phone number input
                                  //       },
                                  //       borderRadius: BorderRadius.circular(12),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(16.0),
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                  //           children: const [
                                  //             Icon(Icons.phone, color: Colors.grey),
                                  //             SizedBox(width: 12),
                                  //             Text(
                                  //               'CONTINUE FOR HOME SCREEN',
                                  //               style: TextStyle(
                                  //                 fontSize: 14,
                                  //                 fontWeight: FontWeight.w500,
                                  //                 color: Colors.grey,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 5),
                                  // Terms Text
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        height: 1.5,
                                      ),
                                      children: [
                                        const TextSpan(text: 'By continuing,you agree to Purify\'s '),
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                            color: Colors.blue[400],
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: Colors.blue[400],
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              // Health Issues Section with Fixed Search
                              Column(
                                children: [
                                  // Fixed Search Bar
                                  TextField(
                                    onChanged: controller.filterHealthIssues,
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
                                  const SizedBox(height: 16),
                                  
                                  // Scrollable List
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
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
                                  const SizedBox(height: 24),
          
                                  // Duration section
                                  
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
          
                  // Fixed Bottom Section
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.currentStep != 4)  // Hide info button on final screen
                          TextButton(
                            onPressed: () {
                              Get.dialog(const InfoDialog());
                            },
                            child: Text(
                              'Why do we Need this Information?',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        
                        const SizedBox(height: 8),
                        
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Continue',
                            onPressed: controller.canProceed() 
                                ? controller.nextStep 
                                : null,
                            backgroundColor: AppColors.primary,
                          ),
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
    );
  }

  Widget _buildGenderOption(String gender, BuildContext context) {
    // final ResponsiveFunctions() = ResponsiveFunctions()Functions();
    
    return GestureDetector(
      onTap: () => controller.updateGender(gender),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveFunctions().buildPadding(context, 12),
          vertical: ResponsiveFunctions().buildPadding(context, 8),
        ),
        decoration: BoxDecoration(
          color: controller.gender == gender 
              ? const Color(0xFF2E4F4F).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: controller.gender == gender 
                ? const Color(0xFF2E4F4F)
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ResponsiveFunctions().buildWidth(context, 20),
              height: ResponsiveFunctions().buildHeight(context, 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.gender == gender 
                      ? AppColors.primary 
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: controller.gender == gender 
                  ? Center(
                      child: Container(
                        width: ResponsiveFunctions().buildWidth(context, 10),
                        height: ResponsiveFunctions().buildHeight(context, 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: ResponsiveFunctions().buildWidth(context, 8)),
            Flexible(
              child: Text(
                gender,
                style: TextStyle(
                  color: controller.gender == gender 
                      ? AppColors.primary 
                      : Colors.grey[600],
                  fontSize: ResponsiveFunctions().buildFont(context, 14),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.nameController,
          onChanged: controller.updateName,
          decoration: InputDecoration(
            hintText: "What's your name?",
            filled: true,
            fillColor: Colors.white,
            errorText: controller.nameError,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        if (controller.genderError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              controller.genderError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        SizedBox(height: ResponsiveFunctions().buildHeight(context, 16)),
        Text("Select DOB "),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => controller.showDatePickerDialog(context),
          child: Container(
            padding: EdgeInsets.all(ResponsiveFunctions().buildPadding(context, 16)),
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.dateError != null ? Colors.red : Colors.grey[200]!
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.formattedDateOfBirth,
                  style: TextStyle(
                    color: controller.dateOfBirth != null
                        ? Colors.black
                        : Colors.grey[600],
                    fontSize: ResponsiveFunctions().buildFont(context, 16),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: ResponsiveFunctions().buildIconSize(context, 20),
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
        if (controller.dateError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              controller.dateError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepper(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Container(
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index <= controller.currentStep 
                      ? AppColors.primary 
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Use existing content based on step
        if (controller.currentStep == 0)
          _buildPersonalInfo(context)
        else if (controller.currentStep == 1)
          Column(
            children: [
              // Health Issues Section
              TextField(
                controller: controller.nameController,
                onChanged: controller.filterHealthIssues,
                decoration: InputDecoration(
                  hintText: 'Search health issues',
                  // ... rest of your existing search field decoration
                ),
              ),
              // ... rest of your existing health issues list
            ],
          )
        else
          _buildTimePickerStep(context),
      ],
    );
  }

  // Add this new method
  Widget _buildTimePickerStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When do you\nwake up?',
          style: AppTextStyles.bold24,
        ),
        const SizedBox(height: 12),
        Text(
          'Choose your wake up time between\n3:30 AM to 8:30 AM',
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: GestureDetector(
            onTap: () => controller.selectTime(context),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 48,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    controller.selectedTime?.format(context) ?? 'Select Time',
                    style: AppTextStyles.medium16,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (controller.selectedTime != null)
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Center(
              child: Text(
                'Wake up time set to ${controller.selectedTime?.format(context)}',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
} 