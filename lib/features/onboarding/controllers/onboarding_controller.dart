import 'package:get/get.dart';
import 'package:purify/core/constants/app_colors.dart';
import 'package:purify/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:purify/features/auth/repositories/auth_repository.dart';
import 'package:purify/features/auth/services/auth_service.dart';
import 'dart:convert';
import 'package:purify/features/navigation/views/main_navigation_screen.dart';
import 'package:purify/features/navigation/controllers/main_navigation_controller.dart';
import 'package:purify/features/time_picker/views/time_picker_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:purify/core/services/google_sheets_service.dart';

class OnboardingController extends GetxController {
  final AuthRepository authRepo;
  final AuthService authService;
  final SharedPreferences _prefs;
  TextEditingController? nameController;
  
  OnboardingController({
    required this.authRepo,
    required this.authService,
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  int _currentStep = 0;
  // String? name;
  String? gender;
  List<String> healthIssues = [];
  List<String> sleepingHabits = [];
  String yogaExperience = '';
  String practiceTime = '';
  String? day;
  String? month;
  String? year;
  List<String> filteredHealthIssues = [
    'Heart Disease',
    'Asthma',
    'Sleep Apnea',
    'Epilepsy',
    'Bipolar Disorder',
    'Psoriasis',
    'Poor Immunity',
    'Diabetes',
    'Hypertension',
    'Arthritis',
    'Depression',
    'Anxiety',
  ];
  Map<String, String> healthIssueSeverity = {};  // Store severity for each issue

  // Birth date (2nd stepper)
  String? birthDay;
  String? birthMonth;
  String? birthYear;

  DateTime? dateOfBirth;

  int get currentStep => _currentStep;

  // Add validation error messages
  String? nameError;
  String? dateError;
  String? genderError;

  // Validation methods
  bool validateName(String? value) {
    if (value == null || value.isEmpty) {
      nameError = 'Name is required';
      update();
      return false;
    }
    if (value.length < 2) {
      nameError = 'Name must be at least 2 characters';
      update();
      return false;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      nameError = 'Name can only contain letters';
      update();
      return false;
    }
    nameError = null;
    update();
    return true;
  }

  bool validateDateOfBirth() {
    if (dateOfBirth == null) {
      dateError = 'Date of birth is required';
      update();
      return false;
    }
    
    final now = DateTime.now();
    final age = now.year - dateOfBirth!.year;
    if (age < 13) {
      dateError = 'You must be at least 13 years old';
      update();
      return false;
    }
    if (age > 100) {
      dateError = 'Please enter a valid date of birth';
      update();
      return false;
    }
    
    dateError = null;
    update();
    return true;
  }

  bool validateGender() {
    if (gender == null || gender!.isEmpty) {
      genderError = 'Please select your gender';
      update();
      return false;
    }
    genderError = null;
    update();
    return true;
  }

  void nextStep() {
    if (_currentStep < 3) {
      if (_currentStep == 2) {
        bool isValid = nameController != null && 
                    nameController!.text.isNotEmpty && 
                    gender != null && 
                    dateOfBirth != null && 
                    healthIssues.isNotEmpty;

        if (isValid) {
          _currentStep++;
          update();
        } else {
          // Show appropriate error message
          if (nameController?.text.isEmpty ?? true) {
            Get.snackbar('Error', 'Please enter your name');
          } else if (gender == null) {
            Get.snackbar('Error', 'Please select your gender');
          } else if (dateOfBirth == null) {
            Get.snackbar('Error', 'Please select your date of birth');
          } else if (healthIssues.isEmpty) {
            Get.snackbar('Error', 'Please select at least one health issue');
          }
        }
      } else {
        _currentStep++;
        update();
      }
    } else {
      // Submit all info and navigate to main screen
      if (selectedTime != null) {
        submitUserInfo().then((_) {
          saveWakeUpTime().then((_) {
            Get.offAll(() => const MainNavigationScreen());
          });
        });
      } else {
        Get.snackbar('Error', 'Please select your wake up time');
      }
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      update();
    }
  }

  void updateName(String value) {
    validateName(value);
    update();
  }

  void updateGender(String value) {
    gender = value;
    validateGender();
    update();
  }

  void toggleHealthIssue(String issue) {
    if (healthIssues.contains(issue)) {
      healthIssues.remove(issue);
    } else {
      healthIssues.add(issue);
    }
    update();
  }

  void toggleSleepingHabit(String habit) {
    if (sleepingHabits.contains(habit)) {
      sleepingHabits.remove(habit);
    } else {
      sleepingHabits.add(habit);
    }

    update();
  }

  void updateYogaExperience(String value) {
    yogaExperience = value;
    update();
  }

  void updatePracticeTime(String value) {
    practiceTime = value;
    update();
  }

  void toggleYogaExperience(String value) {
    yogaExperience = yogaExperience == value ? '' : value;
    update();
  }

  void togglePracticeTime(String value) {
    practiceTime = practiceTime == value ? '' : value;
    update();
  }

  void completeOnboarding() {
    // Save user preferences and navigate to home
    Get.offAll(() =>  MainNavigationScreen());
  }

  bool canProceed() {
    switch (_currentStep) {
      case 0:
        final user = authService.currentUser.value;
        if (user?.firstName != null && user?.dob != null && user?.gender != null) {
          return true;
        }
        return validateName(nameController?.text) && 
               validateDateOfBirth() && 
               validateGender();
      case 1:
        return healthIssues.isNotEmpty;
      case 2:
        return true;  // For severity selection
      case 3:
        return selectedTime != null;  // For time picker
      default:
        return true;
    }
  }

  void updateDay(String value) {
    day = value;
    update();
  }

  void updateMonth(String value) {
    month = value;
    update();
  }

  void updateYear(String value) {
    year = value;
    update();
  }

  void filterHealthIssues(String query) {
    if (query.isEmpty) {
      filteredHealthIssues = [
        'Heart Disease',
        'Asthma',
        'Sleep Apnea',
        'Epilepsy',
        'Bipolar Disorder',
        'Psoriasis',
        'Poor Immunity',
        'Diabetes',
        'Hypertension',
        'Arthritis',
        'Depression',
        'Anxiety',
      ];
    } else {
      filteredHealthIssues = filteredHealthIssues
          .where((issue) => issue.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void updateHealthIssueSeverity(String issue, String severity) {
    healthIssueSeverity[issue] = severity;
    update();
  }

  String getHealthIssueSeverity(String issue) {
    return healthIssueSeverity[issue] ?? 'Mild';  // Default to Mild
  }

  void toggleSeverity(String issue) {
    final severities = ['Mild', 'Moderate', 'Severe'];
    final currentSeverity = getHealthIssueSeverity(issue);
    final currentIndex = severities.indexOf(currentSeverity);
    final nextIndex = (currentIndex + 1) % severities.length;
    updateHealthIssueSeverity(issue, severities[nextIndex]);
  }

  void updateDateOfBirth(DateTime date) {
    dateOfBirth = date;
    update();
  }

  Future<void> showDatePickerDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      dateOfBirth = picked;
      birthDay = picked.day.toString().padLeft(2, '0');
      birthMonth = picked.month.toString().padLeft(2, '0');
      birthYear = picked.year.toString();
      validateDateOfBirth();
      update();
    }
  }

  String get formattedDateOfBirth {
    if (dateOfBirth != null) {
      return '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}';
    }
    return 'Date of Birth';
  }

  Map<String, double> issuesDurations = {};

  void updateIssueDuration(String issue, double value) {
    issuesDurations[issue] = value;
    update();
  }

  double getIssueDuration(String issue) {
    return issuesDurations[issue] ?? 0.0;
  }

  Future<void> submitUserInfo() async {
    try {
      if (nameController?.text.isEmpty ?? true) {
        Get.snackbar('Error', 'Please enter your name');
        return;
      }

      if (dateOfBirth == null) {
        Get.snackbar('Error', 'Please select your date of birth');
        return;
      }

      if (gender == null || gender!.isEmpty) {
        Get.snackbar('Error', 'Please select your gender');
        return;
      }

      final phone = authService.getSavedPhone();
      if (phone == null) {
        Get.snackbar('Error', 'Phone number not found');
        return;
      }

      // Save to Google Sheets
      await GoogleSheetsService.insertUser(
        phone: phone,
        name: nameController!.text,
        gender: gender ?? '',
        dob: dateOfBirth?.toIso8601String().split('T')[0] ?? '',
        healthIssues: healthIssues,
        wakeUpTime: selectedTime?.format(Get.context!) ?? '',
      );

      // Continue with existing API call
      final healthProblemDetails = healthIssues.map((issue) => {
        'problem': issue,
        'severity': getHealthIssueSeverity(issue),
        'duration': getIssueDuration(issue).round(),
      }).toList();

      final requestBody = {
        'email': 'user${DateTime.now().millisecondsSinceEpoch}@example.com',
        'fullName': nameController?.text ?? '',
        'gender': gender,
        'phone': phone,
        'dateOfBirth': dateOfBirth?.toIso8601String().split('T')[0],
        'role': 'USER',
        'healthProblemDetails': healthProblemDetails,
        'goals': []
      };

      // Pretty print JSON
      debugPrint('Submitting user data: \n${const JsonEncoder.withIndent('    ').convert(requestBody)}');

      final response = await authRepo.updateUserProfile(requestBody);
      
      if (response.statusCode == 200 && response.body != null) {
        final userData = response.body['data'];
        final updatedUser = UserModel.fromJson(userData);
        await authService.saveUserAndToken(updatedUser);
        
        // Initialize controller before navigation
        Get.put(MainNavigationController(authService: authService));
        Get.offAll(() => const MainNavigationScreen());
      } else {
        Get.snackbar(
          'Error',
          response.body?['message'] ?? 'Failed to save user information',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('Error submitting user info: $e');
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool isChecking = true;  // Add this property

  Future<void> checkAndSkipBasicInfo() async {
    try {
      isChecking = true;
      update();

      final phone = authService.getSavedPhone();
      if (phone == null) {
        isChecking = false;
        update();
        return;
      }

      // First check Google Sheets
      final existingUser = await GoogleSheetsService.getUserByPhone(phone);
      if (existingUser != null) {
        // User exists in sheets, skip to main screen
        Get.offAll(() => const MainNavigationScreen());
        return;
      }

      // If not in sheets, check API
      final response = await authRepo.getUserProfile();
      debugPrint('User Profile Response: ${response.body}');
      
      if (response.statusCode == 200 && response.body != null) {
        final Map<String, dynamic> responseData = response.body['data'];
        final user = UserModel.fromJson(responseData);
        debugPrint('Parsed user: ${user.toString()}');
        
        // Initialize controller before navigation
        Get.put(MainNavigationController(authService: authService));
        
        if (user.firstName != null && 
            user.dob != null && 
            user.gender != null && 
            user.healthProblemDetails != null && 
            user.healthProblemDetails!.isNotEmpty) {
          // Save to Google Sheets for future quick access
          await GoogleSheetsService.insertUser(
            phone: phone,
            name: user.firstName ?? '',
            gender: user.gender ?? '',
            dob: user.dob ?? '',
            healthIssues: user.problems ?? [],
            wakeUpTime: '', // Add wake up time if available
          );
          Get.offAll(() => const MainNavigationScreen());
          return;
        }
        
        // If not complete, load existing data and show appropriate screen
        loadUserData(user);
        if (user.firstName != null && user.dob != null && user.gender != null) {
          if (user.problems != null && user.problems!.isNotEmpty) {
            _currentStep = 2;  // Go to severity screen
          } else {
            _currentStep = 1;  // Go to health issues screen
          }
        } else {
          _currentStep = 0;  // Go to basic info screen
        }
        update();
      }
    } catch (e) {
      debugPrint('Error checking user data: $e');
      _currentStep = 0;
    } finally {
      isChecking = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    checkAndSkipBasicInfo();
    
    // Load saved wake up time
    final savedTime = _prefs.getString(_timeKey);
    if (savedTime != null) {
      final dateTime = DateTime.parse(savedTime);
      selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      update();
    }
  }

  void loadUserData(UserModel user) {
    nameController?.text = user.firstName ?? '';
    dateOfBirth = user.dob != null ? DateTime.parse(user.dob!) : null;
    gender = user.gender ?? '';
    healthIssues = user.problems ?? [];
    
    // Load severity and duration for each health problem
    if (user.healthProblemDetails != null) {
      for (var detail in user.healthProblemDetails!) {
        // Set severity
        healthIssueSeverity[detail.healthProblem.name] = detail.severity;
        
        // Calculate months duration
        if (detail.sinceWhen != null) {
          final sinceDate = DateTime.parse(detail.sinceWhen);
          final now = DateTime.now();
          final monthsDifference = (now.year - sinceDate.year) * 12 + 
                                 (now.month - sinceDate.month);
          issuesDurations[detail.healthProblem.name] = monthsDifference.toDouble();
        }
      }
    }
    update();
  }

  @override
  void onClose() {
    nameController?.dispose();
    nameController = null;
    super.onClose();
  }

  UserModel? get currentUser => authService.currentUser.value;

  // Add these properties at the start of the class
  TimeOfDay? selectedTime;
  static const String _timeKey = 'wake_up_time';

  // Add these methods to the class
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

  void onTimePickerContinue() {
    if (selectedTime != null) {
      saveWakeUpTime().then((_) {
        Get.offAll(() => const MainNavigationScreen());
      });
    }
  }
} 