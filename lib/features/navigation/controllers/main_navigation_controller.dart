import 'package:get/get.dart';
import '../../auth/services/auth_service.dart';

class MainNavigationController extends GetxController {
  final AuthService _authService;

  MainNavigationController({
    required AuthService authService,
  }) : _authService = authService;

  String get userName => _authService.currentUser.value?.firstName ?? 'User';
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
} 