import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppController>();
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(ctrl),
            const SizedBox(height: 16),
            _buildStatsRow(ctrl),
            const SizedBox(height: 20),
            _buildSection('My Account', [
              _MenuItem(icon: Icons.shopping_bag_outlined, iconColor: AppColors.royalBlue, label: 'My Orders', badge: '3', onTap: () => Get.toNamed(AppRoutes.orderTracking)),
              _MenuItem(icon: Icons.location_on_outlined, iconColor: AppColors.deepPurple, label: 'Saved Addresses', onTap: () {}),
              _MenuItem(icon: Icons.credit_card_outlined, iconColor: AppColors.successGreen, label: 'Payment Methods', onTap: () {}),
              _MenuItem(icon: Icons.favorite_border_outlined, iconColor: AppColors.errorRed, label: 'Wishlist', badge: ctrl.wishlistIds.length.toString(), onTap: () => ctrl.setNavIndex(3)),
              _MenuItem(icon: Icons.card_giftcard_outlined, iconColor: AppColors.luxuryGold, label: 'Loyalty Rewards', badge: '🏆', onTap: () {}),
              _MenuItem(icon: Icons.people_outline_rounded, iconColor: AppColors.infoBlue, label: 'Refer & Earn', onTap: () {}),
            ]),
            const SizedBox(height: 16),
            _buildSection('Support', [
              _MenuItem(icon: Icons.chat_bubble_outline_rounded, iconColor: AppColors.royalBlue, label: 'Live Chat Support', onTap: () => Get.toNamed(AppRoutes.chat)),
              _MenuItem(icon: Icons.help_outline_rounded, iconColor: AppColors.deepPurple, label: 'Help Center', onTap: () {}),
              _MenuItem(icon: Icons.star_border_rounded, iconColor: AppColors.luxuryGold, label: 'Rate the App', onTap: () {}),
              _MenuItem(icon: Icons.notifications_outlined, iconColor: AppColors.warningAmber, label: 'Notifications', badge: '3', onTap: () => Get.toNamed(AppRoutes.notifications)),
            ]),
            const SizedBox(height: 16),
            _buildSection('Preferences', [
              _ToggleMenuItem(icon: Icons.dark_mode_outlined, iconColor: AppColors.elegantBlack, label: 'Dark Mode', value: ctrl.isDarkMode, onToggle: (_) => ctrl.toggleDarkMode()),
              _MenuItem(icon: Icons.language_outlined, iconColor: AppColors.infoBlue, label: 'Language', trailing: 'English', onTap: () {}),
              _MenuItem(icon: Icons.attach_money_rounded, iconColor: AppColors.successGreen, label: 'Currency', trailing: 'USD (\$)', onTap: () {}),
              _MenuItem(icon: Icons.security_outlined, iconColor: AppColors.textMedium, label: 'Privacy Policy', onTap: () {}),
              _MenuItem(icon: Icons.settings_outlined, iconColor: AppColors.textMedium, label: 'Settings', onTap: () => Get.toNamed(AppRoutes.settings)),
            ]),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => _showLogoutDialog(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.errorRed.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.errorRed.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.errorRed.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.logout_rounded, color: AppColors.errorRed, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Text('Logout', style: AppTextStyles.labelLarge.copyWith(color: AppColors.errorRed)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.errorRed),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text('LuxeMart v1.0.0', style: AppTextStyles.caption),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppController ctrl) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.goldGradient,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: const Center(child: Text('👤', style: TextStyle(fontSize: 34))),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
                        child: const Icon(Icons.edit_rounded, size: 12, color: AppColors.royalBlue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alexandra Johnson', style: AppTextStyles.headingMedium.copyWith(color: Colors.white)),
                    const SizedBox(height: 3),
                    Text('alex.johnson@email.com', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('👑', style: TextStyle(fontSize: 11)),
                          const SizedBox(width: 4),
                          Text('Premium Member', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.settings),
                icon: const Icon(Icons.settings_outlined, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(AppController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Obx(() => Row(
          children: [
            _StatItem('Orders', '12', Icons.shopping_bag_outlined, AppColors.royalBlue),
            _vDivider(),
            _StatItem('Wishlist', '${ctrl.wishlistIds.length}', Icons.favorite_border_rounded, AppColors.errorRed),
            _vDivider(),
            _StatItem('Reviews', '5', Icons.star_border_rounded, AppColors.luxuryGold),
            _vDivider(),
            _StatItem('Points', '2,400', Icons.card_giftcard_outlined, AppColors.successGreen),
          ],
        )),
      ),
    );
  }

  Widget _vDivider() => Container(width: 1, height: 36, color: AppColors.midGrey);

  Widget _buildSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 10),
            child: Text(title, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight, fontWeight: FontWeight.w600, letterSpacing: 0.5, fontSize: 11)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
            ),
            child: Column(
              children: items.asMap().entries.map((e) {
                return Column(
                  children: [
                    e.value,
                    if (e.key < items.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 1),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Logout', style: AppTextStyles.headingMedium),
      content: Text('Are you sure you want to logout?', style: AppTextStyles.bodyMedium),
      actions: [
        TextButton(onPressed: () => Get.back(),
            child: Text('Cancel', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMedium))),
        TextButton(onPressed: () { Get.back(); Get.offAllNamed(AppRoutes.login); },
            child: Text('Logout', style: AppTextStyles.labelMedium.copyWith(color: AppColors.errorRed))),
      ],
    ));
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _StatItem(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.labelLarge.copyWith(fontSize: 15, color: AppColors.elegantBlack)),
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
      ],
    ),
  );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String? badge, trailing;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.iconColor, required this.label, this.badge, this.trailing, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppTextStyles.labelLarge.copyWith(fontSize: 14))),
          if (badge != null && badge!.isNotEmpty && int.tryParse(badge!) != null && int.parse(badge!) > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(10)),
              child: Text(badge!, style: AppTextStyles.badge.copyWith(fontSize: 10)),
            ),
          if (trailing != null)
            Text(trailing!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium, fontSize: 12)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppColors.textLight),
        ],
      ),
    ),
  );
}

class _ToggleMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final RxBool value;
  final Function(bool) onToggle;
  const _ToggleMenuItem({required this.icon, required this.iconColor, required this.label, required this.value, required this.onToggle});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: AppTextStyles.labelLarge.copyWith(fontSize: 14))),
        Obx(() => Switch(value: value.value, onChanged: onToggle, activeColor: AppColors.royalBlue)),
      ],
    ),
  );
}
