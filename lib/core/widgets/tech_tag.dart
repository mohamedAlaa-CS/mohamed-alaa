import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Pill-shaped tech tag with cyan tint background.
/// Used for listing skills on project cards.
class TechTag extends StatelessWidget {
  const TechTag(
    this.label, {
    super.key,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tagColor = color ?? AppColors.primaryCyan;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tagColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: tagColor.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: tagColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
