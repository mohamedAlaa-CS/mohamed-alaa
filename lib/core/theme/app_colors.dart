import 'package:flutter/material.dart';

/// Design system colors — Premium Developer Portfolio.
///
/// Bespoke Editorial Light Palette (أبيض في بني في بيج):
/// - أبيض عاجي دافئ / Paper Ivory (خلفية عاجية هادئة وكروت ناصعة)
/// - بني إسبريسو عميق / Deep Ink Espresso (عناوين حادة وواضحة جداً)
/// - كراميل وترابيع دافئة / Warm Caramel & Rust (لون تمييز حيوي يبرز بوضوح)
/// - رمادي قهوة دافئ / Warm Charcoal Mocha (نصوص ثانوية مقروءة بتباين ممتاز)
abstract final class AppColors {
  // ── Core Editorial Light Tones ─────────────────────────────────
  /// بني إسبريسو عميق — Deep, sharp espresso ink for main headings and titles.
  static const Color espresso = Color(0xFF1A120B);

  /// كراميل دافئ وحيوي — Distinct, vibrant warm caramel accent that pops clearly.
  static const Color caramel = Color(0xFFB45309);

  /// كراميل ذهبي فاتح — Warm amber/honey caramel for hover states and highlights.
  static const Color caramelLight = Color(0xFFD97706);

  /// نص المتن والقراءة — Warm charcoal-mocha with crisp contrast for comfortable reading.
  static const Color textBody = Color(0xFF4A4036);

  /// نصوص خافتة والتفاصيل — Muted warm slate for captions, dates, and secondary labels.
  static const Color textMuted = Color(0xFF786D61);

  /// بيج دافئ — Warm linen sand beige for containers and tags.
  static const Color warmBeige = Color(0xFFF3EDE2);

  /// بيج خافت — Muted sand tone for subtle section surfaces.
  static const Color sand = Color(0xFFE8DFD0);

  /// أبيض عاجي دافئ — Soft alabaster paper off-white background.
  static const Color warmPaper = Color(0xFFFAF7F2);

  // ── Backwards-Compatibility Aliases ────────────────────────────
  static const Color olive = caramel;
  static const Color oliveLight = caramelLight;
  static const Color warmIvory = onSurface;
  static const Color warmIvoryMuted = onSurfaceVariant;
  static const Color terracotta = caramel;
  static const Color terracottaLight = caramelLight;
  static const Color primaryTerracotta = caramel;
  static const Color primaryAmber = caramel;
  static const Color primaryHoney = caramelLight;
  static const Color primaryPurple = espresso;
  static const Color primaryCyan = caramel;

  // ── Surface Hierarchy (أبيض عاجي ناعم وبيج) ──────────────────────
  static const Color background = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDim = Color(0xFFF4EDE2);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFF3EDE2);
  static const Color surfaceContainerLow = Color(0xFFF8F3EA);
  static const Color surfaceContainer = Color(0xFFF2ECE0);
  static const Color surfaceContainerHigh = Color(0xFFEBE3D4);
  static const Color surfaceContainerHighest = Color(0xFFE2D7C6);
  static const Color surfaceVariant = Color(0xFFEFE7DB);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ── On-Surface (تباين نصوص واضح ومريح) ─────────────────────────
  static const Color onSurface = Color(0xFF1A120B);
  static const Color onSurfaceVariant = Color(0xFF4A4036);
  static const Color inverseSurface = Color(0xFF1A120B);
  static const Color inverseOnSurface = Color(0xFFFAF7F2);

  // ── Primary (بني إسبريسو عميق) ──────────────────────────────────
  static const Color primary = Color(0xFF1A120B);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFF3ECE2);
  static const Color onPrimaryContainer = Color(0xFF1A120B);
  static const Color inversePrimary = Color(0xFFE2D7C6);

  // ── Secondary (كراميل دافئ مميز) ───────────────────────────────
  static const Color secondary = Color(0xFFB45309);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFEF3C7);
  static const Color onSecondaryContainer = Color(0xFF78350F);

  // ── Tertiary (بيج رملي دافئ) ────────────────────────────────────
  static const Color tertiary = Color(0xFFD97706);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFFBEB);
  static const Color onTertiaryContainer = Color(0xFF92400E);

  // ── Error ──────────────────────────────────────────────────────
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onErrorContainer = Color(0xFF410E0B);

  // ── Outline (حدود بيج وكافيه رقيقة) ────────────────────────────
  static const Color outline = Color(0xFFDFD5C7);
  static const Color outlineVariant = Color(0xFFEBE3D4);

  // ── Misc ───────────────────────────────────────────────────────
  static const Color surfaceTint = Color(0xFF1A120B);
  static const Color scrim = Color(0xFF000000);
  static const Color shadow = Color(0x1A1A120B);

  // ── Gradients ──────────────────────────────────────────────────
  /// Rich gradient flowing from deep espresso to warm caramel-rust.
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF1A120B), // Deep espresso
      Color(0xFF9A3412), // Warm rich caramel-rust
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient45 = LinearGradient(
    colors: [
      Color(0xFF1A120B),
      Color(0xFF9A3412),
    ],
    transform: GradientRotation(0.785398), // 45 degrees
  );

  static const LinearGradient subtleCardGradient = LinearGradient(
    colors: [
      Color(0x0AB45309), // ~4% subtle warm amber/caramel
      Color(0x00000000), // transparent
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
