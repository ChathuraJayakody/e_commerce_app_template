import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Discover Premium\nBrands',
      subtitle:
          'Explore thousands of luxury products from world-renowned brands, curated just for you.',
      emoji: '🛍️',
      gradientColors: [Color(0xFF1A3C8F), Color(0xFF2D5BE3)],
      bgEmojis: ['✨', '💎', '⭐', '🌟'],
    ),
    _OnboardingData(
      title: 'Fast & Secure\nDelivery',
      subtitle:
          'Get your orders delivered safely to your doorstep with real-time tracking and instant updates.',
      emoji: '🚀',
      gradientColors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
      bgEmojis: ['📦', '🗺️', '✅', '⚡'],
    ),
    _OnboardingData(
      title: 'Exclusive Deals\n& Rewards',
      subtitle:
          'Unlock special discounts, flash sales and loyalty rewards every single day.',
      emoji: '🏆',
      gradientColors: [Color(0xFFD4AF37), Color(0xFFB8962E)],
      bgEmojis: ['🎁', '💰', '🔥', '🎯'],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _pages.length,
            itemBuilder: (context, index) =>
                _buildPage(_pages[index]),
          ),
          // Skip Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage < _pages.length - 1)
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoutes.login),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Skip',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                  // Page counter
                  Text(
                    '${_currentPage + 1}/${_pages.length}',
                    style: AppTextStyles.caption.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
                child: Column(
                  children: [
                    // Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (index) {
                        final bool isActive = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 16 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 28),
                    // Next / Get Started Button
                    GestureDetector(
                      onTap: _goToNext,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage < _pages.length - 1
                                  ? 'Continue'
                                  : 'Get Started',
                              style: AppTextStyles.buttonLarge.copyWith(
                                color: _pages[_currentPage].gradientColors[0],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: _pages[_currentPage].gradientColors[0],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Already have account
                    if (_currentPage == _pages.length - 1)
                      GestureDetector(
                        onTap: () => Get.offNamed(AppRoutes.login),
                        child: Text(
                          'Already have an account? Sign In',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_OnboardingData data) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [...data.gradientColors, data.gradientColors.last.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative Background Elements
          ...List.generate(4, (index) {
            final positions = [
              const Offset(30, 120),
              const Offset(280, 80),
              const Offset(60, 380),
              const Offset(310, 300),
            ];
            return Positioned(
              left: positions[index].dx,
              top: positions[index].dy,
              child: Opacity(
                opacity: 0.15,
                child: Text(
                  data.bgEmojis[index],
                  style: TextStyle(fontSize: 40 + (index % 2) * 20.0),
                ),
              ),
            );
          }),
          // Decorative Circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.pagePaddingH,
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                // Illustration
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      data.emoji,
                      style: const TextStyle(fontSize: 90),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Title
                Text(
                  data.title,
                  style: AppTextStyles.displayLarge.copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Subtitle
                Text(
                  data.subtitle,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> gradientColors;
  final List<String> bgEmojis;

  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradientColors,
    required this.bgEmojis,
  });
}
