import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});
  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _selectedTab = 0;
  final _tabs = ['All', 'Pending', 'Shipped', 'Delivered', 'Cancelled'];

  final _orders = [
    {'id': '#LM-20250128', 'items': '3 items', 'total': '\$249.97', 'status': 'Shipped', 'date': 'Jan 28, 2025', 'statusColor': AppColors.infoBlue},
    {'id': '#LM-20250115', 'items': '1 item', 'total': '\$1,199.99', 'status': 'Delivered', 'date': 'Jan 15, 2025', 'statusColor': AppColors.successGreen},
    {'id': '#LM-20250108', 'items': '2 items', 'total': '\$89.98', 'status': 'Delivered', 'date': 'Jan 08, 2025', 'statusColor': AppColors.successGreen},
    {'id': '#LM-20241228', 'items': '1 item', 'total': '\$299.99', 'status': 'Cancelled', 'date': 'Dec 28, 2024', 'statusColor': AppColors.errorRed},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Text('My Orders', style: AppTextStyles.headingLarge),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(child: _buildOrderList()),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _tabs.length,
        itemBuilder: (_, i) {
          final isSelected = i == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected ? null : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Text(_tabs[i], style: AppTextStyles.labelSmall.copyWith(
                  color: isSelected ? Colors.white : AppColors.textMedium, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, fontSize: 12))),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _orders.length,
      itemBuilder: (_, i) {
        final o = _orders[i];
        return GestureDetector(
          onTap: () => _showTrackingDetail(o),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 46, height: 46,
                      decoration: BoxDecoration(color: AppColors.royalBlueSurface, borderRadius: BorderRadius.circular(12)),
                      child: const Center(child: Text('📦', style: TextStyle(fontSize: 22))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o['id'] as String, style: AppTextStyles.labelLarge.copyWith(fontSize: 14)),
                          const SizedBox(height: 3),
                          Text('${o['items']}  •  ${o['date']}', style: AppTextStyles.bodySmall.copyWith(fontSize: 12)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(o['total'] as String, style: AppTextStyles.priceSmall),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (o['statusColor'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(o['status'] as String, style: AppTextStyles.caption.copyWith(
                              color: o['statusColor'] as Color, fontWeight: FontWeight.w700, fontSize: 10)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedPremiumButton(
                        text: 'Track Order', height: 36,
                        onTap: () => _showTrackingDetail(o),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PremiumButton(
                        text: 'Reorder', height: 36,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTrackingDetail(Map<String, dynamic> order) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.borderGrey, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('Track Order', style: AppTextStyles.headingMedium),
                const Spacer(),
                Text(order['id'] as String, style: AppTextStyles.labelMedium.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 24),
            _TrackingTimeline(),
            const SizedBox(height: 24),
            PremiumButton(text: 'Close', onTap: () => Get.back()),
            const SizedBox(height: 8),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  final _steps = [
    {'title': 'Order Placed', 'subtitle': 'Jan 28, 2025 – 10:30 AM', 'done': true},
    {'title': 'Payment Confirmed', 'subtitle': 'Jan 28, 2025 – 10:31 AM', 'done': true},
    {'title': 'Order Processing', 'subtitle': 'Jan 28, 2025 – 02:15 PM', 'done': true},
    {'title': 'Shipped', 'subtitle': 'Jan 29, 2025 – 08:45 AM', 'done': true},
    {'title': 'Out for Delivery', 'subtitle': 'Jan 30, 2025 – 09:00 AM', 'done': false},
    {'title': 'Delivered', 'subtitle': 'Expected Jan 30, 2025', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _steps.asMap().entries.map((e) {
        final i = e.key;
        final step = e.value;
        final isLast = i == _steps.length - 1;
        final isDone = step['done'] as bool;
        final isCurrent = !isDone && (i == 0 || (_steps[i - 1]['done'] as bool));
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    gradient: isDone || isCurrent ? AppColors.primaryGradient : null,
                    color: isDone || isCurrent ? null : AppColors.lightGrey,
                    shape: BoxShape.circle,
                    boxShadow: isDone || isCurrent ? [BoxShadow(color: AppColors.royalBlue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))] : [],
                  ),
                  child: Center(
                    child: isDone
                        ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                        : isCurrent
                            ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))
                            : Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.borderGrey, shape: BoxShape.circle)),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2, height: 40,
                    decoration: BoxDecoration(
                      gradient: isDone ? AppColors.primaryGradient : null,
                      color: isDone ? null : AppColors.borderGrey,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4, bottom: isLast ? 0 : 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step['title'] as String, style: AppTextStyles.labelLarge.copyWith(
                        fontSize: 13, color: isDone || isCurrent ? AppColors.elegantBlack : AppColors.textLight)),
                    const SizedBox(height: 2),
                    Text(step['subtitle'] as String, style: AppTextStyles.caption.copyWith(
                        color: isDone ? AppColors.textMedium : AppColors.textLight, fontSize: 11)),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
