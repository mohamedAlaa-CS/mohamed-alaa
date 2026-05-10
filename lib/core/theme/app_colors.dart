import 'package:flutter/material.dart';

/// Design system colors from Google Stitch - Premium Developer Portfolio.
///
/// Color palette anchored in a deep obsidian-space background with
/// vibrant Purple (#6C63FF) and Cyan (#00D9FF) accents.
abstract final class AppColors {
  // ── Brand Accents ──────────────────────────────────────────────
  static const Color primaryPurple = Color(0xFF6C63FF);
  static const Color primaryCyan = Color(0xFF00D9FF);

  // ── Surface Hierarchy ──────────────────────────────────────────
  static const Color background = Color(0xFF0A0A1A);
  static const Color surface = Color(0xFF13121B);
  static const Color surfaceDim = Color(0xFF13121B);
  static const Color surfaceBright = Color(0xFF393842);
  static const Color surfaceContainerLowest = Color(0xFF0E0D16);
  static const Color surfaceContainerLow = Color(0xFF1B1B24);
  static const Color surfaceContainer = Color(0xFF1F1F28);
  static const Color surfaceContainerHigh = Color(0xFF2A2933);
  static const Color surfaceContainerHighest = Color(0xFF35343E);
  static const Color surfaceVariant = Color(0xFF35343E);
  static const Color cardBackground = Color(0xFF16162A);

  // ── On-Surface ─────────────────────────────────────────────────
  static const Color onSurface = Color(0xFFE4E1EE);
  static const Color onSurfaceVariant = Color(0xFFC7C4D8);
  static const Color inverseSurface = Color(0xFFE4E1EE);
  static const Color inverseOnSurface = Color(0xFF302F39);

  // ── Primary ────────────────────────────────────────────────────
  static const Color primary = Color(0xFFC4C0FF);
  static const Color onPrimary = Color(0xFF2000A4);
  static const Color primaryContainer = Color(0xFF8781FF);
  static const Color onPrimaryContainer = Color(0xFF1B0091);
  static const Color inversePrimary = Color(0xFF4F44E2);

  // ── Secondary ──────────────────────────────────────────────────
  static const Color secondary = Color(0xFFAEECFF);
  static const Color onSecondary = Color(0xFF003641);
  static const Color secondaryContainer = Color(0xFF00D9FF);
  static const Color onSecondaryContainer = Color(0xFF005B6C);

  // ── Tertiary ───────────────────────────────────────────────────
  static const Color tertiary = Color(0xFFFFB785);
  static const Color onTertiary = Color(0xFF502500);
  static const Color tertiaryContainer = Color(0xFFDB761F);
  static const Color onTertiaryContainer = Color(0xFF461F00);

  // ── Error ──────────────────────────────────────────────────────
  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // ── Outline ────────────────────────────────────────────────────
  static const Color outline = Color(0xFF918FA1);
  static const Color outlineVariant = Color(0xFF464555);

  // ── Misc ───────────────────────────────────────────────────────
  static const Color surfaceTint = Color(0xFFC4C0FF);
  static const Color scrim = Color(0xFF000000);
  static const Color shadow = Color(0xFF000000);

  // ── Gradients ──────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient45 = LinearGradient(
    colors: [primaryPurple, primaryCyan],
    transform: GradientRotation(0.785398), // 45 degrees
  );

  static const LinearGradient subtleCardGradient = LinearGradient(
    colors: [
      Color(0x1A6C63FF), // 10% purple
      Color(0x00000000), // transparent
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
