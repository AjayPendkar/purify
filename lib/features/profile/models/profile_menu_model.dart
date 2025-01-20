import 'package:flutter/material.dart';

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final Function() onTap;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
} 