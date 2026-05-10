import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Secondary outlined button with purple border and transparent background.
class OutlinedButtonWidget extends StatefulWidget {
  const OutlinedButtonWidget({
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
  State<OutlinedButtonWidget> createState() => _OutlinedButtonWidgetState();
}

class _OutlinedButtonWidgetState extends State<OutlinedButtonWidget> {
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
          color: _isHovered
              ? AppColors.primaryPurple.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: AppColors.primaryPurple,
            width: 1.5,
          ),
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
                    Icon(
                      widget.icon,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
