import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/base_screen.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/time_picker_controller.dart';

class TimePickerScreen extends GetView<TimePickerController> {
  const TimePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                const Spacer(),
                // Clock Widget
                Center(
                  child: GetBuilder<TimePickerController>(
                    builder: (controller) => Column(
                      children: [
                        GestureDetector(
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
                        const SizedBox(height: 24),
                        if (controller.selectedTime != null)
                          Text(
                            'Wake up time set to ${controller.selectedTime?.format(context)}',
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: 'Continue',
                  onPressed: controller.selectedTime != null 
                      ? () => controller.onContinue()
                      : null,
                  backgroundColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 