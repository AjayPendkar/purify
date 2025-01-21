import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/home/views/home_screen.dart';
import '../../../core/constants/app_colors.dart';

class TimePickerController extends GetxController {
  TimeOfDay? selectedTime;
  final _prefs = Get.find<SharedPreferences>();
  static const String _timeKey = 'wake_up_time';

  void selectTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: selectedTime ?? const TimeOfDay(hour: 5, minute: 30),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((picked) {
      if (picked != null) {
        final selectedMinutes = picked.hour * 60 + picked.minute;
        final minAllowedMinutes = 3 * 60 + 30; // 3:30 AM
        final maxAllowedMinutes = 8 * 60 + 30; // 8:30 AM

        if (selectedMinutes >= minAllowedMinutes && 
            selectedMinutes <= maxAllowedMinutes) {
          selectedTime = picked;
          update();
        } else {
          Get.snackbar(
            'Invalid Time',
            'Please select a time between 3:30 AM and 8:30 AM',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    });
  }

  Future<void> saveWakeUpTime() async {
    if (selectedTime != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      await _prefs.setString(_timeKey, selectedDateTime.toIso8601String());
    }
  }

  void onContinue() {
    if (selectedTime != null) {
      saveWakeUpTime().then((_) {
        Get.off(() => const HomeScreen(userName: "User"));
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    final savedTime = _prefs.getString(_timeKey);
    if (savedTime != null) {
      final dateTime = DateTime.parse(savedTime);
      selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      update();
    }
  }
} 