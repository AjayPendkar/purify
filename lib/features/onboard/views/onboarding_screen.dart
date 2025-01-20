import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/universal_image.dart';
import '../models/onboarding_content.dart';
import '../../auth/views/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final RxInt currentPage = 0.obs;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) => currentPage.value = index,
                itemCount: onboardingContents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        Text(
                          onboardingContents[index].title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        UniversalImage(
                          imagePath: onboardingContents[index].image,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          onboardingContents[index].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingContents.length,
                      (index) => Obx(
                        () => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage.value == index
                                ? AppColors.primary
                                : AppColors.greyLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => CustomButton(
                      text: currentPage.value == onboardingContents.length - 1
                          ? 'Get Started'
                          : 'Next',
                      onPressed: () {
                        if (currentPage.value == onboardingContents.length - 1) {
                          Get.off(() => const LoginScreen());
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 