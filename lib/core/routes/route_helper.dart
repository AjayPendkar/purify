import 'package:get/get.dart';
import 'package:purify/features/onboard/views/welcome_to_purify_screen.dart';
import 'package:purify/splash.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/onboarding/views/user_info_screen.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/onboarding/bindings/onboarding_binding.dart';
import '../../features/navigation/views/main_navigation_screen.dart';
import '../../features/navigation/bindings/main_navigation_binding.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/views/otp_verification_screen.dart';
class RouteHelper {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String userInfo = '/user-info';
  static const String wellcomeToPurify = '/well-come-to-Purify';
  static const String mainNavigation = '/main-navigation';

  static String getSplashRoute() => splash;
  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getOtpRoute() => otp;
  static String getUserInfoRoute() => userInfo;
  static String getWellcomeToPurifyRoute() => wellcomeToPurify;
  static String getMainNavigationRoute() => mainNavigation;

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(userName: Get.find<AuthService>().currentUser.value?.firstName ?? 'User'),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: userInfo,
      page: () => const UserInfoScreen(),
      binding: OnboardingBinding(),
      bindings: [OnboardingBinding()],
    ),
    GetPage(
      name: wellcomeToPurify,
      page: () =>  WelcomeToPurifyScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: mainNavigation,
      page: () => const MainNavigationScreen(),
      binding: MainNavigationBinding(),
      bindings: [MainNavigationBinding()],
    ),
    GetPage(
      name: otp,
      page: () => OtpVerificationScreen(
        phoneNumber: Get.arguments as String,
      ),
      binding: AuthBinding(),
    ),
  ];
} 