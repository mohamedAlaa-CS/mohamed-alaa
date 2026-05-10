import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';

/// Skills section with animated skill cards in a responsive grid.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;
    final crossCount = width >= AppConstants.desktopBreakpoint
        ? 4
        : (isDesktop ? 3 : 2);

    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
      child: Column(
        children: [
          const SectionHeading(
            title: 'My Skills',
            subtitle: 'Technologies and tools I work with',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: AppConstants.skills.length,
            itemBuilder: (context, index) {
              final skill = AppConstants.skills[index];
              return _SkillCard(
                name: skill.name,
                icon: skill.icon,
                level: skill.level,
              );
            },
          ),
        ],
      ),
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
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(20),
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
            Text(
              widget.name,
              style: AppTextStyles.labelLarge,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
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
