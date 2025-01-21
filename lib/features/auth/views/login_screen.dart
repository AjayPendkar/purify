import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purify/core/widgets/base_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/login_controller.dart';
import '../../../core/constants/app_text_styles.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.lazyPut(() => LoginController());

    return BaseScreen(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Login in or Sign up',
                  style: AppTextStyles.medium24,
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyLight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          '+91',
                          style: AppTextStyles.medium16,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: AppColors.greyLight,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          style: AppTextStyles.regular16,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Phone number',
                            hintStyle: AppTextStyles.regular16,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    if (!controller.isPhoneValid && 
                        controller.phoneController.text.isNotEmpty) {
                      return const Text(
                        'Please enter a valid mobile number',
                        style: AppTextStyles.regular14,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const Spacer(),
                GetBuilder<LoginController>(
                  builder: (controller) => CustomButton(
                    text: 'Continue',
                    onPressed: controller.isPhoneValid ? controller.login : null,
                    isLoading: controller.isLoading,
                    backgroundColor: controller.isPhoneValid
                        ? AppColors.primary
                        : AppColors.greyLight,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
