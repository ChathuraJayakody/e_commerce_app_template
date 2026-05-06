class AppDimensions {
  AppDimensions._();

  // === SPACING ===
  static const double spaceXXS = 4.0;
  static const double spaceXS = 8.0;
  static const double spaceSM = 12.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 20.0;
  static const double spaceXL = 24.0;
  static const double spaceXXL = 32.0;
  static const double spaceXXXL = 40.0;
  static const double spaceHuge = 48.0;

  // === BORDER RADIUS ===
  static const double radiusXS = 6.0;
  static const double radiusSM = 10.0;
  static const double radiusMD = 14.0;
  static const double radiusLG = 18.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusFull = 100.0;

  // === ICON SIZES ===
  static const double iconXS = 14.0;
  static const double iconSM = 18.0;
  static const double iconMD = 22.0;
  static const double iconLG = 26.0;
  static const double iconXL = 32.0;

  // === BUTTON HEIGHTS ===
  static const double buttonHeightSM = 40.0;
  static const double buttonHeightMD = 50.0;
  static const double buttonHeightLG = 56.0;

  // === CARD DIMENSIONS ===
  static const double cardProductWidth = 160.0;
  static const double cardProductHeight = 220.0;
  static const double cardImageHeight = 140.0;

  // === APP BAR ===
  static const double appBarHeight = 60.0;

  // === BOTTOM NAV ===
  static const double bottomNavHeight = 70.0;

  // === HORIZONTAL PADDING ===
  static const double pagePaddingH = 20.0;
  static const double pagePaddingV = 16.0;
}

class AppStrings {
  AppStrings._();

  static const String appName = 'LuxeMart';
  static const String appTagline = 'Shop Premium. Live Luxuriously.';
  static const String appVersion = '1.0.0';

  // Onboarding
  static const List<Map<String, String>> onboardingData = [
    {
      'title': 'Discover Premium\nBrands',
      'subtitle':
          'Explore thousands of luxury products from world-renowned brands, curated just for you.',
      'image': 'onboarding1',
    },
    {
      'title': 'Fast & Secure\nDelivery',
      'subtitle':
          'Get your orders delivered safely to your doorstep with real-time tracking and updates.',
      'image': 'onboarding2',
    },
    {
      'title': 'Exclusive Deals\n& Offers',
      'subtitle':
          'Unlock special discounts, flash sales and loyalty rewards every single day.',
      'image': 'onboarding3',
    },
  ];

  // Navigation
  static const String navHome = 'Home';
  static const String navCategory = 'Category';
  static const String navCart = 'Cart';
  static const String navWishlist = 'Wishlist';
  static const String navProfile = 'Profile';
}
