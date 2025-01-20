import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class CourseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseController());
  }
} 