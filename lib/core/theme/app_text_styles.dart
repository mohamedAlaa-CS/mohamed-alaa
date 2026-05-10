import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography system from Google Stitch design – Inter font family.
///
/// Hierarchy uses extreme weight contrast:
///  - Display/Headline: Bold (700) & ExtraBold (800) with tight tracking
///  - Body: Regular (400) with generous 1.6 line height
///  - Label: SemiBold (600) with subtle letter-spacing
abstract final class AppTextStyles {
  // ── Display ────────────────────────────────────────────────────
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 64,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -1.28, // -0.02em
    color: AppColors.onSurface,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.48, // -0.01em
    color: AppColors.onSurface,
  );

  // ── Headline ───────────────────────────────────────────────────
  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.onSurface,
  );

  static TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
  );

  // ── Body ───────────────────────────────────────────────────────
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );

  // ── Label ──────────────────────────────────────────────────────
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.7, // 0.05em
    color: AppColors.onSurface,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.24, // 0.02em
    color: AppColors.onSurfaceVariant,
  );

  // ── Navigation ─────────────────────────────────────────────────
  static TextStyle navLink = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.28,
    color: AppColors.onSurfaceVariant,
  );

  // ── Button ─────────────────────────────────────────────────────
  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.32,
    color: Colors.white,
  );
}
