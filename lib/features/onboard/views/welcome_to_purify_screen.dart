import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/universal_image.dart';
import '../controllers/welcome_controller.dart';
import '../../../core/widgets/base_screen.dart';

class WelcomeToPurifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveFunctions();
    final controller = Get.put(WelcomeController());

    return BaseScreen(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(responsive.buildPadding(context, 24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Spacer(),
                Text(
                  'Welcome to Purify',
                  style: GoogleFonts.poppins(
                    fontSize: responsive.buildFont(context, 28),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: responsive.buildHeight(context, 200)),
                UniversalImage(
                  imagePath: 'assets/images/logo_green.svg',
                  height: responsive.buildHeight(context, 120),
                  width: responsive.buildWidth(context, 120),
                ),
                SizedBox(height: responsive.buildHeight(context, 150)),
                Text(
                  'Discover Yoga, Ayurveda, and Lifestyle\nSolutions for a healthier, happier you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.buildFont(context, 16),
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: responsive.buildHeight(context, 32)),
                CustomButton(
                  text: 'Get Started',
                  onPressed: controller.getStarted,
                  backgroundColor: AppColors.primary,
                ),
                SizedBox(height: responsive.buildHeight(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: responsive.buildFont(context, 14),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToLogin,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: responsive.buildFont(context, 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.buildHeight(context, 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 