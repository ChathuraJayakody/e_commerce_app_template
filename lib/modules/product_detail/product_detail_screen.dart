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

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedImageIndex = 0;
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;
  bool _isDescExpanded = false;

  ProductModel get product =>
      Get.arguments as ProductModel? ?? DummyData.products.first;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedColor = product.colors.isNotEmpty ? product.colors.first : null;
    _selectedSize = product.sizes.isNotEmpty ? product.sizes.first : null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildImageSliver(appController),
              SliverToBoxAdapter(child: _buildProductInfo()),
              SliverToBoxAdapter(child: _buildColorSelector()),
              SliverToBoxAdapter(child: _buildSizeSelector()),
              SliverToBoxAdapter(child: _buildTabSection()),
              SliverToBoxAdapter(child: _buildRelatedProducts()),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar(appController)),
        ],
      ),
    );
  }

  Widget _buildImageSliver(AppController appController) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
            ),
            child: const Icon(Icons.arrow_back_ios_rounded, size: 18, color: AppColors.elegantBlack),
          ),
        ),
      ),
      actions: [
        Obx(() => IconButton(
          icon: Icon(
            appController.isInWishlist(product.id) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: appController.isInWishlist(product.id) ? AppColors.errorRed : AppColors.elegantBlack,
          ),
          onPressed: () => appController.toggleWishlist(product.id),
        )),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: AppColors.elegantBlack),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: product.images.length,
                      onPageChanged: (i) => setState(() => _selectedImageIndex = i),
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.fromLTRB(60, 80, 60, 16),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: _getProductEmoji(),
                        ),
                      ),
                    ),
                    // Thumbnail strip
                    Positioned(
                      left: 12,
                      top: 90,
                      child: Column(
                        children: List.generate(product.images.length, (index) => GestureDetector(
                          onTap: () => setState(() => _selectedImageIndex = index),
                          child: Container(
                            width: 44,
                            height: 44,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _selectedImageIndex == index ? AppColors.royalBlue : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(child: Text(_getProductEmojiString(), style: const TextStyle(fontSize: 22))),
                          ),
                        )),
                      ),
                    ),
                    // Page indicator
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
                        child: Text('${_selectedImageIndex + 1}/${product.images.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.royalBlueSurface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(product.category,
                    style: AppTextStyles.caption.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              if (product.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                  child: Text('NEW', style: AppTextStyles.badge.copyWith(color: AppColors.successGreen, fontSize: 10)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(product.name, style: AppTextStyles.displaySmall),
          const SizedBox(height: 4),
          Text('by ${product.brand}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            children: [
              StarRating(rating: product.rating, size: 16, reviewCount: product.reviewCount),
              const SizedBox(width: 12),
              Text('${_formatNumber(product.soldCount)} sold',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textMedium)),
            ],
          ),
          const SizedBox(height: 16),
          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.priceLarge),
              const SizedBox(width: 10),
              if (product.hasDiscount) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text('\$${product.originalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.priceStrikethrough.copyWith(fontSize: 14)),
                ),
                const SizedBox(width: 8),
                DiscountBadge(percent: product.discountPercent, fontSize: 11),
              ],
            ],
          ),
          if (product.stockCount <= 10) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Container(width: 8, height: 8,
                    decoration: const BoxDecoration(color: AppColors.warningAmber, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('Only ${product.stockCount} left in stock!',
                    style: AppTextStyles.caption.copyWith(color: AppColors.warningAmber, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Color', style: AppTextStyles.headingSmall),
              const SizedBox(width: 8),
              Text(_selectedColor ?? '', style: AppTextStyles.bodySmall.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: product.colors.map((color) {
              final isSelected = color == _selectedColor;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : AppColors.borderGrey,
                      width: 1.5,
                    ),
                    boxShadow: isSelected ? [BoxShadow(color: AppColors.royalBlue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))] : [],
                  ),
                  child: Text(color, style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.textDark, fontWeight: FontWeight.w500)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Size', style: AppTextStyles.headingSmall),
                  const SizedBox(width: 8),
                  Text(_selectedSize ?? '', style: AppTextStyles.bodySmall.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w500)),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text('Size Guide', style: AppTextStyles.labelSmall.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: product.sizes.map((size) {
              final isSelected = size == _selectedSize;
              return GestureDetector(
                onTap: () => setState(() => _selectedSize = size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 52,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : AppColors.borderGrey,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(size, style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Quantity
          Row(
            children: [
              Text('Quantity', style: AppTextStyles.headingSmall),
              const Spacer(),
              Container(
                decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    _QtyButton(icon: Icons.remove_rounded, onTap: () { if (_quantity > 1) setState(() => _quantity--); }),
                    Container(
                      width: 44,
                      child: Center(
                        child: Text('$_quantity', style: AppTextStyles.headingSmall.copyWith(fontSize: 16)),
                      ),
                    ),
                    _QtyButton(icon: Icons.add_rounded, onTap: () { if (_quantity < product.stockCount) setState(() => _quantity++); }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.royalBlue,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.royalBlue,
            indicatorWeight: 2.5,
            labelStyle: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
            tabs: const [Tab(text: 'Description'), Tab(text: 'Specs'), Tab(text: 'Reviews')],
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDescription(),
                _buildSpecs(),
                _buildReviews(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.7),
            maxLines: _isDescExpanded ? null : 4,
            overflow: _isDescExpanded ? null : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () => setState(() => _isDescExpanded = !_isDescExpanded),
            child: Text(_isDescExpanded ? 'Show Less' : 'Read More',
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.royalBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecs() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      child: Column(
        children: product.specifications.entries.map((entry) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(entry.key, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textLight, fontSize: 12)),
              ),
              Expanded(child: Text(entry.value, style: AppTextStyles.labelMedium.copyWith(color: AppColors.textDark, fontSize: 12))),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildReviews() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
      separatorBuilder: (_, __) => const Divider(height: 16),
      itemCount: DummyData.reviews.take(2).length,
      itemBuilder: (context, index) {
        final review = DummyData.reviews[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.royalBlueSurface,
              child: Text(review.userName[0], style: AppTextStyles.labelMedium.copyWith(color: AppColors.royalBlue)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(review.userName, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
                      const Spacer(),
                      StarRating(rating: review.rating, size: 11, showCount: false),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(review.comment, style: AppTextStyles.bodySmall.copyWith(fontSize: 11, height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRelatedProducts() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          SectionHeader(title: 'You May Also Like', onActionTap: () {}),
          const SizedBox(height: 16),
          SizedBox(
            height: 248,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.pagePaddingH),
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemCount: DummyData.products.take(4).length,
              itemBuilder: (context, index) => ProductCard(product: DummyData.products[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppController appController) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedPremiumButton(
              text: 'Add to Cart',
              height: 50,
              onTap: () => appController.addToCart(product, color: _selectedColor, size: _selectedSize, qty: _quantity),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PremiumButton(
              text: 'Buy Now',
              height: 50,
              onTap: () {
                appController.addToCart(product, color: _selectedColor, size: _selectedSize, qty: _quantity);
                Get.toNamed(AppRoutes.checkout);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProductEmoji() {
    const emojis = {'1': '📱', '2': '📱', '3': '👟', '4': '⌚', '5': '👔', '6': '🎧', '7': '💻', '8': '💄'};
    return Text(emojis[product.id] ?? '🛍️', style: const TextStyle(fontSize: 100));
  }

  String _getProductEmojiString() {
    const emojis = {'1': '📱', '2': '📱', '3': '👟', '4': '⌚', '5': '👔', '6': '🎧', '7': '💻', '8': '💄'};
    return emojis[product.id] ?? '🛍️';
  }

  String _formatNumber(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)],
        ),
        child: Icon(icon, size: 18, color: AppColors.elegantBlack),
      ),
    );
  }
}
