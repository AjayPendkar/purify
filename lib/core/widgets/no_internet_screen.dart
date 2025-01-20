import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'custom_button.dart';
import 'universal_image.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;
  
  const NoInternetScreen({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UniversalImage(
                imagePath: 'assets/images/no-internet.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),
              Text(
                'No Internet Connection',
                style: AppTextStyles.bold24.copyWith(
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Please check your internet connection and try again',
                style: AppTextStyles.regular16.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Retry',
                onPressed: onRetry,
                backgroundColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 