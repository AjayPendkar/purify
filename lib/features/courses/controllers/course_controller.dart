import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/course_model.dart';

class CourseController extends GetxController {
  List<AsanaModel> asanas = [];
  String selectedCategory = 'All';
  bool isLoading = false;
  String? error;

  @override
  void onInit() {
    super.onInit();
    loadAsanas();
  }

  Future<void> loadAsanas() async {
    try {
      error = null;
      isLoading = true;
      update();

      // Add delay to ensure proper initialization
      await Future.delayed(const Duration(milliseconds: 100));

      final String jsonString = await rootBundle.loadString(
        'assets/json/diabetes_courseDB.json'
      );
      
      if (jsonString.isEmpty) {
        throw Exception('JSON file is empty');
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      asanas = jsonList.map((json) => AsanaModel.fromJson(json)).toList();

    } catch (e) {
      error = e.toString();
      print('Error loading asanas: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  List<AsanaModel> getFilteredAsanas() {
    if (error != null) {
      print('Error state: $error');
      return [];
    }
    
    if (selectedCategory == 'All') {
      return asanas;
    }
    return asanas.where((asana) => 
      asana.category.toLowerCase() == selectedCategory.toLowerCase()
    ).toList();
  }

  void setCategory(String category) {
    selectedCategory = category;
    update();
  }

  // Method to retry loading if failed
  void retryLoading() {
    loadAsanas();
  }
} 