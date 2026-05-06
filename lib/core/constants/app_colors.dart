import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === PRIMARY PALETTE ===
  static const Color royalBlue = Color(0xFF1A3C8F);
  static const Color royalBlueDark = Color(0xFF0F2460);
  static const Color royalBlueLight = Color(0xFF2D5BE3);
  static const Color royalBlueSurface = Color(0xFFEEF2FF);

  static const Color deepPurple = Color(0xFF6B21A8);
  static const Color deepPurpleDark = Color(0xFF4C1D7E);
  static const Color deepPurpleLight = Color(0xFF9333EA);
  static const Color deepPurpleSurface = Color(0xFFF5F0FF);

  // === GRADIENT COMBOS ===
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [royalBlue, deepPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1A3C8F), Color(0xFF6B21A8), Color(0xFF9333EA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF5C842), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A3C8F), Color(0xFF2D5BE3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF0F0F1A), Color(0xFF1A1A2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // === ACCENT COLORS ===
  static const Color luxuryGold = Color(0xFFD4AF37);
  static const Color luxuryGoldLight = Color(0xFFF5C842);
  static const Color luxuryGoldDark = Color(0xFFB8962E);

  static const Color successGreen = Color(0xFF22C55E);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color infoBlue = Color(0xFF3B82F6);

  // === NEUTRAL PALETTE ===
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color softWhite = Color(0xFFF8F9FE);
  static const Color lightGrey = Color(0xFFF1F3F9);
  static const Color midGrey = Color(0xFFE2E8F0);
  static const Color borderGrey = Color(0xFFCBD5E1);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color textMedium = Color(0xFF64748B);
  static const Color textDark = Color(0xFF334155);
  static const Color elegantBlack = Color(0xFF0F172A);
  static const Color nearBlack = Color(0xFF1E293B);

  // === DARK THEME ===
  static const Color darkBackground = Color(0xFF0A0A16);
  static const Color darkSurface = Color(0xFF12121F);
  static const Color darkCard = Color(0xFF1C1C2E);
  static const Color darkBorder = Color(0xFF2D2D45);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // === CATEGORY COLORS ===
  static const List<Color> categoryColors = [
    Color(0xFF3B82F6),
    Color(0xFF8B5CF6),
    Color(0xFFEC4899),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF06B6D4),
    Color(0xFF84CC16),
  ];

  // === SALE / DISCOUNT ===
  static const Color saleRed = Color(0xFFE53935);
  static const Color saleBadge = Color(0xFFFF4444);

  // === SOCIAL COLORS ===
  static const Color googleRed = Color(0xFFDB4437);
  static const Color facebookBlue = Color(0xFF4267B2);
  static const Color appleBlack = Color(0xFF000000);
}
