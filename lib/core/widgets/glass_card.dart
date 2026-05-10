import 'dart:ui';

import 'package:flutter/material.dart';

/// Glassmorphism card with backdrop blur, semi-transparent fill,
/// and luminescent 1px border.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 12,
    this.blurAmount = 20,
    this.opacity = 0.08,
    this.borderOpacity = 0.12,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double blurAmount;
  final double opacity;
  final double borderOpacity;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: (borderColor ?? Colors.white)
                  .withValues(alpha: borderOpacity),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
