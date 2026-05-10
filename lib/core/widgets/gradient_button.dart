import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Primary CTA button with purple → cyan gradient fill and glow effect.
class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width,
    this.height = 52,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final double height;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: AppColors.primaryGradient45,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.15),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(widget.text, style: AppTextStyles.button),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
