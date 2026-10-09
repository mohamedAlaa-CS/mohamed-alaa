import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography system from Google Stitch design – Inter font family.
///
/// Hierarchy uses extreme weight and color contrast:
///  - Display/Headline: Deep Espresso Ink (Bold 700 / ExtraBold 800)
///  - Body: Warm Charcoal Mocha (Regular 400) with generous 1.7 line height
///  - Label: SemiBold 600 with subtle letter-spacing
///  - Captions & Dates: Muted warm slate for clear secondary distinction
abstract final class AppTextStyles {
  // ── Display ────────────────────────────────────────────────────
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 64,
    fontWeight: FontWeight.w800,
    height: 1.18,
    letterSpacing: -1.0,
    color: AppColors.onSurface,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 44,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
    color: AppColors.onSurface,
  );

  // ── Headline ───────────────────────────────────────────────────
  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.35,
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
    height: 1.7,
    color: AppColors.textBody,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: AppColors.textBody,
  );

  // ── Label ──────────────────────────────────────────────────────
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.5,
    color: AppColors.onSurface,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.25,
    color: AppColors.textMuted,
  );

  // ── Navigation ─────────────────────────────────────────────────
  static TextStyle navLink = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.28,
    color: AppColors.textBody,
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
