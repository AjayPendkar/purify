import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purify/features/auth/repositories/auth_repository.dart';
import 'package:purify/features/auth/services/auth_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/otp_controller.dart';
import '../../../core/widgets/base_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController(
      authRepository: Get.find<AuthRepository>(),
      authService: Get.find<AuthService>(),
      phoneNumber: phoneNumber,
    ));

    return BaseScreen(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Log in or Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyDark,
                    ),
                    children: [
                      const TextSpan(
                          text: 'Please enter the code we just sent to\n'),
                      TextSpan(
                        text: '(+91) $phoneNumber',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: ' to proceed'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: controller.otpControllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.greyLight),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.primary),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty && index > 0) {
                            controller.otpControllers[index].clear();
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Resend OTP via:'),
                    TextButton.icon(
                      onPressed: () => controller.resendOtp(isSMS: true),
                      icon: const Icon(Icons.message, size: 18),
                      label: const Text('SMS'),
                    ),
                    TextButton.icon(
                      onPressed: () => controller.resendOtp(isSMS: false),
                      icon: const Icon(Icons.phone, size: 18),
                      label: const Text('Call'),
                    ),
                  ],
                ),
                const Spacer(),
                GetBuilder<OtpController>(
                  builder: (controller) => CustomButton(
                    text: 'Continue',
                    onPressed: () => controller.verifyOtp(phoneNumber, otp: controller.otp),
                    isLoading: controller.isLoading,
                    backgroundColor: AppColors.primary,
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
