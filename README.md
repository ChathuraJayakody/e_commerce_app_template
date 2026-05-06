# 🛍️ LuxeMart — Premium Flutter E-Commerce App Template

> **A world-class, production-ready Flutter e-commerce UI kit** designed to impress clients and win high-value projects on Fiverr and beyond.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![GetX](https://img.shields.io/badge/State-GetX-8B5CF6?style=for-the-badge)
![License](https://img.shields.io/badge/License-Commercial-D4AF37?style=for-the-badge)

---

## ✨ Preview

LuxeMart is a **luxury-grade Flutter e-commerce template** featuring 16+ polished screens, premium animations, dark mode, GetX state management, and an elegant Royal Blue + Deep Purple + Gold colour palette.

---

## 🗂️ Project Structure

```
luxemart/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── bindings/       # AppController (GetX global state)
│   │   ├── routes/         # AppRoutes — all named routes
│   │   └── theme/          # Light + Dark ThemeData
│   ├── core/
│   │   └── constants/      # AppColors, AppTextStyles, AppDimensions
│   ├── data/
│   │   └── models/         # ProductModel, CategoryModel, ReviewModel + DummyData
│   ├── modules/            # Feature screens (one folder per screen)
│   │   ├── splash/
│   │   ├── onboarding/
│   │   ├── auth/           # login, signup, forgot_password, otp
│   │   ├── home/
│   │   ├── category/
│   │   ├── product_detail/
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── wishlist/
│   │   ├── profile/
│   │   ├── order_tracking/
│   │   ├── notifications/
│   │   ├── reviews/
│   │   ├── vendor/
│   │   ├── settings/
│   │   ├── chat/
│   │   └── search/
│   └── widgets/
│       ├── common/         # PremiumButton, PremiumTextField, SectionHeader, etc.
│       └── product/        # ProductCard, ProductListCard
├── assets/
│   ├── images/
│   ├── icons/
│   ├── fonts/              # Add Poppins font files here
│   └── data/
├── pubspec.yaml
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK **≥ 3.0.0** ([install guide](https://docs.flutter.dev/get-started/install))
- Dart SDK **≥ 3.0.0**
- Android Studio / VS Code with Flutter extension

### 1 — Clone or extract the project

```bash
# If downloaded as ZIP:
unzip luxemart.zip -d luxemart
cd luxemart
```

### 2 — Add Poppins fonts

Download Poppins from [Google Fonts](https://fonts.google.com/specimen/Poppins) and place the following files in `assets/fonts/`:

```
assets/fonts/
├── Poppins-Regular.ttf
├── Poppins-Medium.ttf
├── Poppins-SemiBold.ttf
├── Poppins-Bold.ttf
└── Poppins-ExtraBold.ttf
```

### 3 — Install dependencies

```bash
flutter pub get
```

### 4 — Run the app

```bash
# Android
flutter run

# iOS (macOS only)
flutter run -d ios

# Web preview
flutter run -d chrome
```

---

## 📱 Screens Included

| # | Screen | Description |
|---|--------|-------------|
| 1 | **Splash** | Animated logo, gold gradient, smooth transition |
| 2 | **Onboarding** | 3 slides, smooth page indicator, skip/start |
| 3 | **Login** | Email + password, social buttons (Google/Facebook/Apple) |
| 4 | **Sign Up** | Full registration with terms acceptance |
| 5 | **Forgot Password** | Email reset flow with success state |
| 6 | **OTP Verification** | 6-digit code input with countdown resend |
| 7 | **Home** | Banner slider, categories, flash sale countdown, product sections |
| 8 | **Category** | Grid/list toggle, filter sheet, sort options |
| 9 | **Product Detail** | Image gallery, variants, tabs (desc/specs/reviews), add to cart |
| 10 | **Cart** | Swipe-to-delete items, coupon code, delivery options, summary |
| 11 | **Checkout** | 3-step (address → payment → confirm), order success dialog |
| 12 | **Wishlist** | Grid with quick add-to-cart |
| 13 | **Profile** | Stats, menu sections, dark mode toggle |
| 14 | **Order Tracking** | Order list + animated timeline bottom sheet |
| 15 | **Notifications** | Read/unread grouped notifications |
| 16 | **Reviews** | Rating breakdown, add review form |
| 17 | **Vendor Store** | Seller profile, stats, products |
| 18 | **Settings** | Dark mode, language, notifications, privacy |
| 19 | **Live Chat** | Bubble chat UI with support agent |
| 20 | **Search** | Recent, trending, live results |

---

## 🎨 Design System

### Colour Palette

| Token | Value | Usage |
|-------|-------|-------|
| `royalBlue` | `#1A3C8F` | Primary |
| `deepPurple` | `#6B21A8` | Secondary |
| `luxuryGold` | `#D4AF37` | Accents / Premium |
| `softWhite` | `#F8F9FE` | Background |
| `elegantBlack` | `#0F172A` | Text |

### Typography

All text uses the **Poppins** typeface via `AppTextStyles`:  
`displayLarge` → `headingMedium` → `bodyMedium` → `caption`

---

## ⚙️ State Management — GetX

Global state is managed via `AppController` (registered permanently in `main.dart`):

```dart
final ctrl = Get.find<AppController>();

// Cart
ctrl.addToCart(product);
ctrl.removeFromCart(index);
ctrl.cartTotal;      // double
ctrl.cartCount;      // int

// Wishlist
ctrl.toggleWishlist(productId);
ctrl.isInWishlist(productId);  // bool

// Theme
ctrl.toggleDarkMode();

// Navigation
ctrl.setNavIndex(2);  // jump to Cart tab
```

---

## 🔌 Backend Integration Guide

The project is designed to be **API-ready**. Replace dummy data calls with your own data layer:

### REST / Firebase

1. Create a `services/` folder inside `lib/`
2. Add `ApiService`, `AuthService`, `ProductService`
3. Replace `DummyData.products` calls with async service calls
4. Uncomment Firebase dependencies in `pubspec.yaml`

```dart
// Example — replace dummy data in HomeScreen:
final products = await ProductService.getFeatured();
```

### Recommended packages (already in pubspec)

- `dio` — HTTP client
- `shared_preferences` — local storage
- `connectivity_plus` — network status

---

## 🌙 Dark Mode

Dark mode is fully implemented. Toggle it via:

- **Profile screen** → Dark Mode toggle  
- **Settings screen** → Dark Mode toggle  
- Programmatically: `Get.find<AppController>().toggleDarkMode()`

---

## 🌍 Multi-Language Ready

The app uses string constants in `AppStrings`. To add i18n:

1. Add `easy_localization` or `flutter_localizations` to `pubspec.yaml`
2. Replace string literals with translation keys
3. Add `.json` / `.arb` locale files in `assets/`

---

## 💳 Payment Integration

The checkout screen supports:
- **Credit / Debit Card** — integrate Stripe (`flutter_stripe`)
- **PayPal** — integrate via `paypal_payment`
- **Apple Pay / Google Pay** — integrate `pay` package
- **Cash on Delivery** — no integration needed

---

## 📦 Assets Setup

Place placeholder images in `assets/images/` with names matching product IDs:
```
assets/images/
├── product1.png
├── product2.png
├── banner1.png
├── onboarding1.png
└── ...
```

The app currently uses emoji placeholders — swap for `Image.asset()` calls in the product card.

---

## 🛠️ Customisation

| What | Where |
|------|-------|
| Brand name | `AppStrings.appName` in `app_dimensions.dart` |
| Colours | `AppColors` in `app_colors.dart` |
| Typography | `AppTextStyles` in `app_text_styles.dart` |
| Products | `DummyData.products` in `product_model.dart` |
| Categories | `DummyData.categories` in `product_model.dart` |
| Banners | `DummyData.banners` in `product_model.dart` |

---

## 📜 License

This template is licensed for **commercial use**. You may use it as a starting point for client projects. Redistribution or resale of the template itself is not permitted.

---

## 🙋 Support

For customisation requests or questions, please contact via Fiverr.

---

*Built with ❤️ using Flutter × GetX × Premium Design*
