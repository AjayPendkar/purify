import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/responsive.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;

  const CommonAppBar({
    Key? key,
    required this.userName,
    this.onNotificationTap,
    this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello $userName',
              style: AppTextStyles.boldHeading24.copyWith(
                color: Colors.black,
                fontSize: ResponsiveFunctions().buildFont(context, 24),
              ),
            ),
            Text(
              'Lets begin Your Journey',
              style: AppTextStyles.regular16.copyWith(
                color: Colors.grey[600],
                fontSize: ResponsiveFunctions().buildFont(context, 16),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined, color: Colors.black),
          ),
          onPressed: onNotificationTap,
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search, color: Colors.black),
          ),
          onPressed: onSearchTap,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
} 