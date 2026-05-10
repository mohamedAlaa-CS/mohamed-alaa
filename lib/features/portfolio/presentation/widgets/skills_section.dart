import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';

/// Skills section with animated skill cards in a responsive Wrap layout.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isTablet = width >= AppConstants.tabletBreakpoint;
        final double hPad = isTablet ? 40 : 24;

        // Responsive columns: 2 → 3 → 4
        final int columns;
        if (width >= AppConstants.desktopBreakpoint) {
          columns = 4;
        } else if (width >= AppConstants.tabletBreakpoint) {
          columns = 3;
        } else {
          columns = 2;
        }

        const double gap = 16;
        final cardWidth =
            (width - hPad * 2 - gap * (columns - 1)) / columns;

        return Container(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Column(
            children: [
              const SectionHeading(
                title: 'My Skills',
                subtitle: 'Technologies and tools I work with',
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: AppConstants.skills.map((skill) {
                  return SizedBox(
                    width: cardWidth,
                    child: _SkillCard(
                      name: skill.name,
                      icon: skill.icon,
                      level: skill.level,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  const _SkillCard({
    required this.name,
    required this.icon,
    required this.level,
  });

  final String name;
  final IconData icon;
  final double level;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppColors.primaryPurple.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : [],
          gradient: AppColors.subtleCardGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primaryPurple.withValues(alpha: 0.15)
                    : AppColors.primaryPurple.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? AppColors.primaryCyan : AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 14),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.name,
                style: AppTextStyles.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: widget.level,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                valueColor: AlwaysStoppedAnimation<Color>(
                  _isHovered ? AppColors.primaryCyan : AppColors.primaryPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
