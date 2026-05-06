import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../data/models/product_model.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/product/product_card.dart';

// ═══════════════════════════════════════════════════════════
// NOTIFICATIONS SCREEN
// ═══════════════════════════════════════════════════════════
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final _notifs = const [
    {'icon': '🎉', 'title': 'Order Shipped!', 'body': 'Your order #LM-20250128 has been shipped and is on its way.', 'time': '2 min ago', 'type': 'order', 'isRead': false},
    {'icon': '💰', 'title': 'Flash Sale Starts Now!', 'body': 'Up to 70% off on selected electronics. Limited stock!', 'time': '1 hour ago', 'type': 'promo', 'isRead': false},
    {'icon': '⭐', 'title': 'Rate Your Purchase', 'body': 'How was the Nike Air Max 270? Share your review.', 'time': '3 hours ago', 'type': 'review', 'isRead': true},
    {'icon': '🎁', 'title': 'You Earned 200 Points!', 'body': 'Your loyalty points have been updated. Redeem now.', 'time': 'Yesterday', 'type': 'reward', 'isRead': true},
    {'icon': '📦', 'title': 'Order Delivered', 'body': 'Your order #LM-20250115 has been delivered. Enjoy!', 'time': '3 days ago', 'type': 'order', 'isRead': true},
    {'icon': '🔥', 'title': 'Weekend Deals', 'body': 'Exclusive weekend offers just for Premium members.', 'time': '5 days ago', 'type': 'promo', 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Text('Notifications', style: AppTextStyles.headingLarge),
        actions: [TextButton(onPressed: () {}, child: Text('Mark all read', style: AppTextStyles.labelSmall.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600)))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildGroup('New', _notifs.where((n) => !(n['isRead'] as bool)).toList()),
          const SizedBox(height: 20),
          _buildGroup('Earlier', _notifs.where((n) => n['isRead'] as bool).toList()),
        ],
      ),
    );
  }

  Widget _buildGroup(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight, fontWeight: FontWeight.w600, letterSpacing: 0.5, fontSize: 11)),
        const SizedBox(height: 10),
        ...items.map((n) {
          final isRead = n['isRead'] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isRead ? Colors.white : AppColors.royalBlueSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isRead ? Colors.transparent : AppColors.royalBlue.withOpacity(0.15)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: isRead ? AppColors.lightGrey : AppColors.royalBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text(n['icon'] as String, style: const TextStyle(fontSize: 22))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(n['title'] as String, style: AppTextStyles.labelLarge.copyWith(fontSize: 13))),
                          if (!isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.royalBlue, shape: BoxShape.circle)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(n['body'] as String, style: AppTextStyles.bodySmall.copyWith(fontSize: 12, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(n['time'] as String, style: AppTextStyles.caption.copyWith(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// REVIEWS SCREEN
// ═══════════════════════════════════════════════════════════
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  double _userRating = 0;
  final _reviewController = TextEditingController();

  @override
  void dispose() { _reviewController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Text('Reviews & Ratings', style: AppTextStyles.headingLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingOverview(),
            const SizedBox(height: 20),
            _buildAddReview(),
            const SizedBox(height: 20),
            Text('Customer Reviews', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            ...DummyData.reviews.map((r) => _ReviewCard(review: r)).toList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.royalBlue.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text('4.7', style: AppTextStyles.displayLarge.copyWith(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w800)),
              const StarRating(rating: 4.7, size: 16, showCount: false),
              const SizedBox(height: 4),
              Text('9,234 reviews', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70, fontSize: 11)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((star) {
                final pct = [72.0, 18.0, 6.0, 2.5, 1.5][5 - star];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text('$star', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 11)),
                      const SizedBox(width: 4),
                      const Icon(Icons.star_rounded, size: 10, color: AppColors.luxuryGold),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: pct / 100,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation(AppColors.luxuryGold),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('${pct.toInt()}%', style: AppTextStyles.caption.copyWith(color: Colors.white60, fontSize: 10)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddReview() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Write a Review', style: AppTextStyles.headingSmall),
          const SizedBox(height: 14),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _userRating = i + 1.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(i < _userRating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: AppColors.luxuryGold, size: 36),
                ),
              )),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _reviewController,
            maxLines: 3,
            style: AppTextStyles.inputText,
            decoration: InputDecoration(
              hintText: 'Share your experience with this product...',
              hintStyle: AppTextStyles.inputHint,
              filled: true, fillColor: AppColors.lightGrey,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 14),
          PremiumButton(text: 'Submit Review', height: 46, onTap: () {
            Get.snackbar('Review Submitted!', 'Thank you for your feedback.',
                backgroundColor: AppColors.successGreen, colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
            _reviewController.clear();
            setState(() => _userRating = 0);
          }),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;
  const _ReviewCard({required this.review});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.royalBlueSurface,
              child: Text(review.userName[0], style: AppTextStyles.labelLarge.copyWith(color: AppColors.royalBlue)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(review.userName, style: AppTextStyles.labelLarge.copyWith(fontSize: 13)),
                    const SizedBox(width: 6),
                    if (review.isVerified) Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text('✓ Verified', style: AppTextStyles.caption.copyWith(color: AppColors.successGreen, fontWeight: FontWeight.w700, fontSize: 9)),
                    ),
                  ]),
                  StarRating(rating: review.rating, size: 12, showCount: false),
                ],
              ),
            ),
            Text('${review.date.day}/${review.date.month}/${review.date.year}',
                style: AppTextStyles.caption.copyWith(fontSize: 10)),
          ],
        ),
        const SizedBox(height: 10),
        Text(review.comment, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13, height: 1.55)),
        const SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(children: [
                const Icon(Icons.thumb_up_alt_outlined, size: 14, color: AppColors.textLight),
                const SizedBox(width: 4),
                Text('Helpful', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ]),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {},
              child: Text('Report', style: AppTextStyles.caption.copyWith(fontSize: 11, color: AppColors.textLight)),
            ),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════
// VENDOR SCREEN
// ═══════════════════════════════════════════════════════════
class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.heroGradient),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 6))]),
                      child: const Center(child: Text('🍎', style: TextStyle(fontSize: 36))),
                    ),
                    const SizedBox(height: 10),
                    Text('Apple Official Store', style: AppTextStyles.headingMedium.copyWith(color: Colors.white)),
                    const SizedBox(height: 4),
                    const StarRating(rating: 4.9, size: 14, reviewCount: 12450),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _VendorStat('Products', '145'),
                      _VendorStat('Orders', '25K+'),
                      _VendorStat('Rating', '4.9'),
                      _VendorStat('Response', '< 1hr'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('About the Seller', style: AppTextStyles.headingSmall),
                  const SizedBox(height: 8),
                  Text('Apple\'s official storefront on LuxeMart. We offer the full range of Apple products with genuine warranties and authorized after-sales support.',
                      style: AppTextStyles.bodyMedium.copyWith(height: 1.6)),
                  const SizedBox(height: 20),
                  SectionHeader(title: 'Store Products', onActionTap: () {}),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) => ProductCard(product: DummyData.products[i % DummyData.products.length]),
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorStat extends StatelessWidget {
  final String label, value;
  const _VendorStat(this.label, this.value);
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headingSmall.copyWith(color: AppColors.royalBlue, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════
// SETTINGS SCREEN
// ═══════════════════════════════════════════════════════════
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppController>();
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Text('Settings', style: AppTextStyles.headingLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsGroup('Appearance', [
              Obx(() => _SettingsToggle(icon: Icons.dark_mode_outlined, label: 'Dark Mode',
                  value: ctrl.isDarkMode.value, onToggle: (_) => ctrl.toggleDarkMode())),
            ]),
            const SizedBox(height: 16),
            _buildSettingsGroup('Regional', [
              _SettingsTile(icon: Icons.language_outlined, label: 'Language', value: 'English', iconColor: AppColors.infoBlue),
              _SettingsTile(icon: Icons.attach_money_rounded, label: 'Currency', value: 'USD (\$)', iconColor: AppColors.successGreen),
              _SettingsTile(icon: Icons.location_on_outlined, label: 'Country', value: 'United States', iconColor: AppColors.royalBlue),
            ]),
            const SizedBox(height: 16),
            _buildSettingsGroup('Notifications', [
              _SettingsToggle(icon: Icons.notifications_outlined, label: 'Push Notifications', value: true, onToggle: (_) {}),
              _SettingsToggle(icon: Icons.email_outlined, label: 'Email Notifications', value: true, onToggle: (_) {}),
              _SettingsToggle(icon: Icons.local_offer_outlined, label: 'Promotional Offers', value: false, onToggle: (_) {}),
            ]),
            const SizedBox(height: 16),
            _buildSettingsGroup('Privacy & Security', [
              _SettingsTile(icon: Icons.fingerprint_rounded, label: 'Biometric Login', iconColor: AppColors.royalBlue),
              _SettingsTile(icon: Icons.lock_outline_rounded, label: 'Change Password', iconColor: AppColors.deepPurple),
              _SettingsTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', iconColor: AppColors.textMedium),
              _SettingsTile(icon: Icons.description_outlined, label: 'Terms of Service', iconColor: AppColors.textMedium),
            ]),
            const SizedBox(height: 16),
            _buildSettingsGroup('About', [
              _SettingsTile(icon: Icons.info_outline_rounded, label: 'App Version', value: '1.0.0', iconColor: AppColors.textMedium),
              _SettingsTile(icon: Icons.star_border_rounded, label: 'Rate Us', iconColor: AppColors.luxuryGold),
              _SettingsTile(icon: Icons.share_outlined, label: 'Share App', iconColor: AppColors.royalBlue),
            ]),
            const SizedBox(height: 30),
            Center(child: Text('LuxeMart © 2025 · All rights reserved', style: AppTextStyles.caption)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
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
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
          ),
          child: Column(
            children: items.asMap().entries.map((e) => Column(
              children: [
                e.value,
                if (e.key < items.length - 1) const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1)),
              ],
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Color? iconColor;
  const _SettingsTile({required this.icon, required this.label, this.value, this.iconColor});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    child: Row(
      children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(color: (iconColor ?? AppColors.textMedium).withOpacity(0.1), borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, color: iconColor ?? AppColors.textMedium, size: 17),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: AppTextStyles.labelLarge.copyWith(fontSize: 14))),
        if (value != null) Text(value!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium, fontSize: 12)),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textLight),
      ],
    ),
  );
}

class _SettingsToggle extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool value;
  final Function(bool) onToggle;
  const _SettingsToggle({required this.icon, required this.label, required this.value, required this.onToggle});
  @override
  State<_SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<_SettingsToggle> {
  late bool _val;
  @override
  void initState() { super.initState(); _val = widget.value; }
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(color: AppColors.royalBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(9)),
          child: Icon(widget.icon, color: AppColors.royalBlue, size: 17),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(widget.label, style: AppTextStyles.labelLarge.copyWith(fontSize: 14))),
        Switch(value: _val, onChanged: (v) { setState(() => _val = v); widget.onToggle(v); }, activeColor: AppColors.royalBlue),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════
// CHAT SCREEN
// ═══════════════════════════════════════════════════════════
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgController = TextEditingController();
  final _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! Welcome to LuxeMart support. How can I help you today?', 'isMe': false, 'time': '10:30 AM'},
    {'text': 'Hi! I wanted to check on my order #LM-20250128. When will it arrive?', 'isMe': true, 'time': '10:31 AM'},
    {'text': 'Sure, I can check that for you! Your order was shipped yesterday and is expected to arrive within 1-2 business days. 📦', 'isMe': false, 'time': '10:31 AM'},
    {'text': 'Great, thanks! Can I change the delivery address?', 'isMe': true, 'time': '10:32 AM'},
    {'text': 'Unfortunately once the order is shipped we cannot change the delivery address. However, if you miss the delivery, you can reschedule via the tracking link. Is there anything else I can help you with?', 'isMe': false, 'time': '10:32 AM'},
  ];

  @override
  void dispose() { _msgController.dispose(); _scrollController.dispose(); super.dispose(); }

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _msgController.text.trim(), 'isMe': true, 'time': 'Now'});
      _msgController.clear();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _messages.add({'text': 'Thank you for your message! Our support team will get back to you shortly. 😊', 'isMe': false, 'time': 'Now'});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
              child: const Center(child: Text('🎧', style: TextStyle(fontSize: 18))),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Support Team', style: AppTextStyles.headingSmall.copyWith(fontSize: 15)),
                Row(children: [
                  Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.successGreen, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('Online', style: AppTextStyles.caption.copyWith(color: AppColors.successGreen, fontSize: 10)),
                ]),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isMe = m['isMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isMe ? AppColors.primaryGradient : null,
                      color: isMe ? null : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                    ),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(m['text'] as String, style: AppTextStyles.bodySmall.copyWith(
                            color: isMe ? Colors.white : AppColors.textDark, fontSize: 13, height: 1.45)),
                        const SizedBox(height: 4),
                        Text(m['time'] as String, style: AppTextStyles.caption.copyWith(
                            color: isMe ? Colors.white60 : AppColors.textLight, fontSize: 10)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -3))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    style: AppTextStyles.inputText,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: AppTextStyles.inputHint,
                      filled: true, fillColor: AppColors.lightGrey,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: AppColors.royalBlue.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SEARCH SCREEN
// ═══════════════════════════════════════════════════════════
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  final List<String> _recent = ['iPhone 15 Pro', 'Nike Air Max', 'Rolex Watch', 'Sony Headphones'];
  final List<String> _trending = ['MacBook Pro', 'Gucci Bag', 'Samsung Galaxy', 'Zara Blazer', 'Apple Watch'];

  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  List<ProductModel> get _results => _query.isEmpty ? [] :
      DummyData.products.where((p) => p.name.toLowerCase().contains(_query.toLowerCase()) || p.brand.toLowerCase().contains(_query.toLowerCase())).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: AppTextStyles.inputText,
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Search products, brands...',
            hintStyle: AppTextStyles.inputHint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            suffixIcon: _query.isNotEmpty ? GestureDetector(
              onTap: () { _searchController.clear(); setState(() => _query = ''); },
              child: const Icon(Icons.close_rounded, color: AppColors.textLight, size: 18),
            ) : null,
          ),
        ),
      ),
      body: _query.isEmpty ? _buildDiscovery() : _buildResults(),
    );
  }

  Widget _buildDiscovery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_recent.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Searches', style: AppTextStyles.headingSmall),
                TextButton(onPressed: () => setState(() => _recent.clear()),
                    child: Text('Clear', style: AppTextStyles.labelSmall.copyWith(color: AppColors.errorRed))),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _recent.map((term) => GestureDetector(
                onTap: () { _searchController.text = term; setState(() => _query = term); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.history_rounded, size: 14, color: AppColors.textLight),
                      const SizedBox(width: 6),
                      Text(term, style: AppTextStyles.labelSmall.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
          ],
          Text('Trending Now 🔥', style: AppTextStyles.headingSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _trending.asMap().entries.map((e) => GestureDetector(
              onTap: () { _searchController.text = e.value; setState(() => _query = e.value); },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: e.key < 3 ? AppColors.primaryGradient : null,
                  color: e.key < 3 ? null : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: e.key >= 3 ? Border.all(color: AppColors.borderGrey) : null,
                ),
                child: Text(e.value, style: AppTextStyles.labelSmall.copyWith(
                    color: e.key < 3 ? Colors.white : AppColors.textDark, fontSize: 12)),
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),
          Text('Popular Products', style: AppTextStyles.headingSmall),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.68,
            ),
            itemCount: 4,
            itemBuilder: (_, i) => ProductCard(product: DummyData.products[i]),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_results.isEmpty) {
      return EmptyStateWidget(
        emoji: '🔍',
        title: 'No Results Found',
        subtitle: 'We couldn\'t find anything for "$_query". Try different keywords.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Text('${_results.length} results for "$_query"',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium, fontSize: 13)),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.68,
            ),
            itemCount: _results.length,
            itemBuilder: (_, i) => ProductCard(product: _results[i]),
          ),
        ),
      ],
    );
  }
}
