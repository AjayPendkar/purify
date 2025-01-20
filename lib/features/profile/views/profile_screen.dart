import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import '../controllers/profile_controller.dart';
import 'widgets/expandable_menu_item.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: AppColors.greyLight,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
                leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),

      
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const ProfileHeader(
                  name: 'Sai Kiran',
                  email: 'saikiran@gmail.com',
                ),
                SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    
                    ExpandableMenuItem(
                      title: 'Personalized Health',
                      subItems: [
                        'Personalized Wellness',
                        'Health Reports',
                        'My Recommendations',
                      ],
                      onTap: () => controller.onPersonalizedHealthTap(),
                    ),
                    ExpandableMenuItem(
                      title: 'Notifications',
                      subItems: [
                        'Activity Reminders',
                        'Progress Alerts',
                      ],
                      onTap: () => controller.onNotificationsTap(),
                    ),
                    ExpandableMenuItem(
                      title: 'Account Settings',
                      subItems: [
                        'Edit Profile',
                        'Manage Subscriptions',
                      ],
                      onTap: () => controller.onAccountSettingsTap(),
                    ),
                    ExpandableMenuItem(
                      title: 'App Preferences',
                      subItems: [
                        'Saved Content',
                        'Language Preferences',
                      ],
                      onTap: () => controller.onAppPreferencesTap(),
                    ),
                    ExpandableMenuItem(
                      title: 'Legal & Support',
                      subItems: [
                        'Terms of Use',
                        'Privacy Policy',
                        'Report a Bug',
                        'Help Center',
                      ],
                      onTap: () => controller.onLegalSupportTap(),
                    ),
                    ProfileMenuItem(
                      title: 'Log out',
                      showDivider: false,
                      onTap: () => controller.onLogoutTap(),
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