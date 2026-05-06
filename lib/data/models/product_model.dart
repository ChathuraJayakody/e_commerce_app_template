class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final int soldCount;
  final List<String> images;
  final List<String> colors;
  final List<String> sizes;
  final String description;
  final Map<String, String> specifications;
  final bool isNew;
  final bool isFeatured;
  final bool isBestSeller;
  final int stockCount;
  final String vendorId;
  final String vendorName;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.description,
    required this.specifications,
    required this.isNew,
    required this.isFeatured,
    required this.isBestSeller,
    required this.stockCount,
    required this.vendorId,
    required this.vendorName,
  });

  double get discountPercent =>
      originalPrice > price ? ((originalPrice - price) / originalPrice * 100) : 0;

  bool get hasDiscount => originalPrice > price;
}

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int productCount;
  final int colorIndex;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
    required this.colorIndex,
  });
}

class BrandModel {
  final String id;
  final String name;
  final String logo;
  final int productCount;

  const BrandModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.productCount,
  });
}

class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> images;
  final bool isVerified;

  const ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.images,
    required this.isVerified,
  });
}

class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;
  final String gradientStart;
  final String gradientEnd;

  const BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imageUrl,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

// ============================================================
// DUMMY DATA
// ============================================================

class DummyData {
  static const List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Electronics', icon: '📱', productCount: 240, colorIndex: 0),
    CategoryModel(id: '2', name: 'Fashion', icon: '👗', productCount: 530, colorIndex: 1),
    CategoryModel(id: '3', name: 'Beauty', icon: '💄', productCount: 180, colorIndex: 2),
    CategoryModel(id: '4', name: 'Home', icon: '🛋️', productCount: 320, colorIndex: 3),
    CategoryModel(id: '5', name: 'Sports', icon: '⚽', productCount: 210, colorIndex: 4),
    CategoryModel(id: '6', name: 'Jewelry', icon: '💎', productCount: 95, colorIndex: 5),
    CategoryModel(id: '7', name: 'Watches', icon: '⌚', productCount: 75, colorIndex: 6),
    CategoryModel(id: '8', name: 'Books', icon: '📚', productCount: 460, colorIndex: 7),
  ];

  static const List<BrandModel> brands = [
    BrandModel(id: '1', name: 'Apple', logo: '🍎', productCount: 45),
    BrandModel(id: '2', name: 'Samsung', logo: '📺', productCount: 78),
    BrandModel(id: '3', name: 'Nike', logo: '✔', productCount: 120),
    BrandModel(id: '4', name: 'Zara', logo: 'Z', productCount: 95),
    BrandModel(id: '5', name: 'Gucci', logo: 'G', productCount: 32),
    BrandModel(id: '6', name: 'Rolex', logo: '⌚', productCount: 18),
  ];

  static const List<BannerModel> banners = [
    BannerModel(
      id: '1',
      title: 'Summer\nSale 2025',
      subtitle: 'Up to 70% Off',
      buttonText: 'Shop Now',
      imageUrl: 'banner1',
      gradientStart: '#1A3C8F',
      gradientEnd: '#6B21A8',
    ),
    BannerModel(
      id: '2',
      title: 'New\nArrivals',
      subtitle: 'Latest Fashion Drops',
      buttonText: 'Explore',
      imageUrl: 'banner2',
      gradientStart: '#6B21A8',
      gradientEnd: '#9333EA',
    ),
    BannerModel(
      id: '3',
      title: 'Flash\nDeals',
      subtitle: 'Limited Time Only',
      buttonText: 'Grab Now',
      imageUrl: 'banner3',
      gradientStart: '#D4AF37',
      gradientEnd: '#B8962E',
    ),
  ];

  static List<ProductModel> get products => [
    ProductModel(
      id: '1',
      name: 'iPhone 15 Pro Max',
      brand: 'Apple',
      category: 'Electronics',
      price: 1199.99,
      originalPrice: 1399.99,
      rating: 4.9,
      reviewCount: 2847,
      soldCount: 15420,
      images: ['product1', 'product1b', 'product1c'],
      colors: ['Natural Titanium', 'Black Titanium', 'White Titanium', 'Blue Titanium'],
      sizes: ['256GB', '512GB', '1TB'],
      description:
          'The iPhone 15 Pro Max features a titanium design, A17 Pro chip, and the most powerful camera system ever in an iPhone. Experience stunning performance with a 48MP main camera, 5x optical zoom, and Action Button.',
      specifications: {
        'Display': '6.7-inch Super Retina XDR',
        'Chip': 'A17 Pro',
        'Camera': '48MP Main + 12MP Ultra Wide',
        'Battery': '4422 mAh',
        'Storage': '256GB / 512GB / 1TB',
        'OS': 'iOS 17',
      },
      isNew: true,
      isFeatured: true,
      isBestSeller: true,
      stockCount: 45,
      vendorId: 'v1',
      vendorName: 'Apple Official Store',
    ),
    ProductModel(
      id: '2',
      name: 'Samsung Galaxy S24 Ultra',
      brand: 'Samsung',
      category: 'Electronics',
      price: 1099.99,
      originalPrice: 1299.99,
      rating: 4.8,
      reviewCount: 1923,
      soldCount: 11200,
      images: ['product2', 'product2b'],
      colors: ['Titanium Black', 'Titanium Gray', 'Titanium Violet'],
      sizes: ['256GB', '512GB', '1TB'],
      description:
          'Galaxy S24 Ultra with Galaxy AI, 200MP camera, built-in S Pen, and titanium frame for the ultimate Android experience.',
      specifications: {
        'Display': '6.8-inch Dynamic AMOLED 2X',
        'Chip': 'Snapdragon 8 Gen 3',
        'Camera': '200MP Main',
        'Battery': '5000 mAh',
        'Storage': '256GB+',
        'OS': 'Android 14',
      },
      isNew: true,
      isFeatured: true,
      isBestSeller: false,
      stockCount: 62,
      vendorId: 'v2',
      vendorName: 'Samsung Premium Store',
    ),
    ProductModel(
      id: '3',
      name: 'Nike Air Max 270',
      brand: 'Nike',
      category: 'Sports',
      price: 149.99,
      originalPrice: 189.99,
      rating: 4.7,
      reviewCount: 4521,
      soldCount: 28900,
      images: ['product3', 'product3b'],
      colors: ['Triple White', 'Black/Red', 'Blue Fury', 'Volt'],
      sizes: ['7', '8', '9', '10', '11', '12'],
      description:
          'The Nike Air Max 270 delivers all-day comfort with a large Max Air heel unit for full cushioning. Perfect for everyday wear.',
      specifications: {
        'Material': 'Mesh upper',
        'Sole': 'Rubber outsole',
        'Cushioning': 'Max Air 270',
        'Fit': 'True to size',
        'Weight': '310g',
      },
      isNew: false,
      isFeatured: true,
      isBestSeller: true,
      stockCount: 124,
      vendorId: 'v3',
      vendorName: 'Nike Official',
    ),
    ProductModel(
      id: '4',
      name: 'Rolex Submariner Date',
      brand: 'Rolex',
      category: 'Watches',
      price: 9850.00,
      originalPrice: 9850.00,
      rating: 5.0,
      reviewCount: 312,
      soldCount: 890,
      images: ['product4'],
      colors: ['Oystersteel', 'Yellow Gold', 'Everose Gold'],
      sizes: ['41mm'],
      description:
          'The Rolex Submariner is the reference in the world of diving watches. Waterproof to 300 metres, it features a unidirectional rotatable bezel.',
      specifications: {
        'Case': '41mm Oystersteel',
        'Movement': 'Calibre 3235',
        'Water Resistance': '300m/1,000ft',
        'Power Reserve': '70 hours',
        'Crystal': 'Scratch-resistant sapphire',
      },
      isNew: false,
      isFeatured: true,
      isBestSeller: false,
      stockCount: 5,
      vendorId: 'v4',
      vendorName: 'Rolex Authorised Dealer',
    ),
    ProductModel(
      id: '5',
      name: 'Zara Premium Blazer',
      brand: 'Zara',
      category: 'Fashion',
      price: 89.99,
      originalPrice: 129.99,
      rating: 4.5,
      reviewCount: 678,
      soldCount: 3420,
      images: ['product5'],
      colors: ['Black', 'Camel', 'Navy Blue', 'Cream'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      description:
          'Premium structured blazer with a tailored fit. Made from a comfortable stretch fabric for all-day wear.',
      specifications: {
        'Material': '65% Polyester, 35% Viscose',
        'Care': 'Dry Clean Only',
        'Fit': 'Tailored',
        'Style': 'Single Breasted',
      },
      isNew: true,
      isFeatured: false,
      isBestSeller: true,
      stockCount: 89,
      vendorId: 'v5',
      vendorName: 'Zara Official',
    ),
    ProductModel(
      id: '6',
      name: 'Sony WH-1000XM5',
      brand: 'Sony',
      category: 'Electronics',
      price: 299.99,
      originalPrice: 399.99,
      rating: 4.8,
      reviewCount: 5672,
      soldCount: 21300,
      images: ['product6'],
      colors: ['Midnight Black', 'Platinum Silver'],
      sizes: ['One Size'],
      description:
          'Industry-leading noise cancelling with Auto NC Optimizer, crystal clear hands-free calling, and up to 30-hour battery life.',
      specifications: {
        'Driver': '30mm',
        'Frequency': '4Hz–40,000Hz',
        'Battery': '30 hours',
        'Charging': 'USB-C (3 min = 3 hours)',
        'Weight': '250g',
        'Foldable': 'No',
      },
      isNew: false,
      isFeatured: true,
      isBestSeller: true,
      stockCount: 78,
      vendorId: 'v6',
      vendorName: 'Sony Store',
    ),
    ProductModel(
      id: '7',
      name: 'Apple MacBook Pro 14"',
      brand: 'Apple',
      category: 'Electronics',
      price: 1999.00,
      originalPrice: 2199.00,
      rating: 4.9,
      reviewCount: 1344,
      soldCount: 7800,
      images: ['product7'],
      colors: ['Space Black', 'Silver'],
      sizes: ['512GB', '1TB', '2TB'],
      description:
          'MacBook Pro with M3 Pro chip delivers breakthrough performance for demanding workflows with a stunning Liquid Retina XDR display.',
      specifications: {
        'Chip': 'Apple M3 Pro',
        'Display': '14.2-inch Liquid Retina XDR',
        'RAM': '18GB / 36GB',
        'Storage': '512GB - 4TB SSD',
        'Battery': '22 hours',
        'Ports': 'Thunderbolt 4, HDMI, SD Card',
      },
      isNew: true,
      isFeatured: true,
      isBestSeller: false,
      stockCount: 23,
      vendorId: 'v1',
      vendorName: 'Apple Official Store',
    ),
    ProductModel(
      id: '8',
      name: 'Charlotte Tilbury Palette',
      brand: 'Charlotte Tilbury',
      category: 'Beauty',
      price: 79.00,
      originalPrice: 79.00,
      rating: 4.6,
      reviewCount: 892,
      soldCount: 5100,
      images: ['product8'],
      colors: ['Pillow Talk', 'Golden Goddess', 'Bohemian Romance'],
      sizes: ['Standard'],
      description:
          'The iconic Luxury Palette featuring 8 universally flattering shades for eyes and cheeks, inspired by Hollywood glamour.',
      specifications: {
        'Finish': 'Matte & Shimmer',
        'Shades': '8 pans',
        'Net Weight': '16g',
        'Vegan': 'No',
        'Cruelty Free': 'Yes',
      },
      isNew: false,
      isFeatured: false,
      isBestSeller: true,
      stockCount: 143,
      vendorId: 'v7',
      vendorName: 'Charlotte Tilbury Official',
    ),
  ];

  static List<ReviewModel> get reviews => [
    ReviewModel(
      id: 'r1',
      userId: 'u1',
      userName: 'Sarah Johnson',
      userAvatar: 'avatar1',
      rating: 5.0,
      comment:
          'Absolutely stunning product! Exceeded all my expectations. The quality is top-notch and delivery was super fast. Highly recommend!',
      date: DateTime(2025, 1, 15),
      images: [],
      isVerified: true,
    ),
    ReviewModel(
      id: 'r2',
      userId: 'u2',
      userName: 'Michael Chen',
      userAvatar: 'avatar2',
      rating: 4.5,
      comment:
          'Great product overall. Minor packaging issue but the product itself is perfect. Would definitely buy again.',
      date: DateTime(2025, 1, 10),
      images: [],
      isVerified: true,
    ),
    ReviewModel(
      id: 'r3',
      userId: 'u3',
      userName: 'Emma Williams',
      userAvatar: 'avatar3',
      rating: 5.0,
      comment:
          'Love it! Premium quality, beautiful design and fits perfectly. The colour is exactly as shown in the photos.',
      date: DateTime(2025, 1, 5),
      images: [],
      isVerified: false,
    ),
    ReviewModel(
      id: 'r4',
      userId: 'u4',
      userName: 'James Rodriguez',
      userAvatar: 'avatar4',
      rating: 4.0,
      comment:
          'Good product but a bit expensive. Build quality is excellent and it performs as advertised.',
      date: DateTime(2024, 12, 28),
      images: [],
      isVerified: true,
    ),
  ];
}
