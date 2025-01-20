import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? iconColor;

  const ProfileMenuItem({
    Key? key,
    required this.title,
    this.icon,
    required this.onTap,
    this.showDivider = true,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon != null
              ? Icon(icon, color: iconColor ?? Colors.grey[600])
              : null,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),
      ],
    );
  }
} 