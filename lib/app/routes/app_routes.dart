import 'package:get/get.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/auth/login/login_screen.dart';
import '../../modules/auth/signup/signup_screen.dart';
import '../../modules/auth/forgot_password/forgot_password_screen.dart';
import '../../modules/auth/otp/otp_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/product_detail/product_detail_screen.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/checkout/checkout_screen.dart';
import '../../modules/wishlist/wishlist_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/order_tracking/order_tracking_screen.dart';
import '../../modules/notifications/notifications_screen.dart';
import '../../modules/reviews/reviews_screen.dart';
import '../../modules/vendor/vendor_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/chat/chat_screen.dart';
import '../../modules/search/search_screen.dart';
import '../../widgets/common/main_wrapper.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String main = '/main';
  static const String home = '/home';
  static const String category = '/category';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String orderTracking = '/order-tracking';
  static const String notifications = '/notifications';
  static const String reviews = '/reviews';
  static const String vendor = '/vendor';
  static const String settings = '/settings';
  static const String chat = '/chat';
  static const String search = '/search';

  static List<GetPage> get pages => [
        GetPage(
          name: splash,
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: onboarding,
          page: () => const OnboardingScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: login,
          page: () => const LoginScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: signup,
          page: () => const SignUpScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: forgotPassword,
          page: () => const ForgotPasswordScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: otp,
          page: () => const OTPScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: main,
          page: () => const MainWrapper(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: productDetail,
          page: () => const ProductDetailScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: cart,
          page: () => const CartScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: checkout,
          page: () => const CheckoutScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: orderTracking,
          page: () => const OrderTrackingScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: notifications,
          page: () => const NotificationsScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: reviews,
          page: () => const ReviewsScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: vendor,
          page: () => const VendorScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: settings,
          page: () => const SettingsScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: chat,
          page: () => const ChatScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: search,
          page: () => const SearchScreen(),
          transition: Transition.fadeIn,
        ),
      ];
}
