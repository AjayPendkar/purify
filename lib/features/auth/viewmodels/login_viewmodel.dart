// import 'package:flutter/material.dart';

// class LoginViewModel extends ChangeNotifier {
//   final TextEditingController phoneController = TextEditingController();
//   String selectedCountryCode = '+91';
//   bool isLoading = false;

//   void updateCountryCode(String code) {
//     selectedCountryCode = code;
//     notifyListeners();
//   }

//   Future<void> login() async {
//     isLoading = true;
//     notifyListeners();

//     // Add your login logic here
//     await Future.delayed(const Duration(seconds: 2)); // Simulate API call

//     isLoading = false;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }
// } 