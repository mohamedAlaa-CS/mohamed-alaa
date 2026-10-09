import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/section_heading.dart';

/// Skills section with compact, professional skill cards in a responsive grid layout.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < AppConstants.mobileBreakpoint;
        final isTablet = width >= AppConstants.mobileBreakpoint &&
            width < AppConstants.desktopBreakpoint;

        final double hPad = isMobile ? 16 : (isTablet ? 32 : 40);
        final double gap = isMobile ? 10 : 14;

        // Responsive columns for horizontal (Row) cards:
        // Desktop (>= 1050): 4 columns
        // Tablet (>= 680): 3 columns
        // Mobile (>= 360): 2 columns
        // Small Mobile (< 360): 1 column
        final int columns;
        if (width >= 1050) {
          columns = 4;
        } else if (width >= 680) {
          columns = 3;
        } else if (width >= 360) {
          columns = 2;
        } else {
          columns = 1;
        }

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
              SizedBox(height: isMobile ? 28 : 40),
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
                      isMobile: isMobile,
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
    required this.isMobile,
  });

  final String name;
  final IconData icon;
  final double level;
  final bool isMobile;

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final iconBoxSize = widget.isMobile ? 34.0 : 40.0;
    final iconSize = widget.isMobile ? 17.0 : 20.0;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -3.0 : 0.0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isHovered
                  ? [
                      Colors.white,
                      const Color(0xFFFFF9F0),
                    ]
                  : [
                      Colors.white,
                      const Color(0xFFFAF7F2),
                    ],
            ),
            border: Border.all(
              color: _isHovered
                  ? AppColors.caramel.withValues(alpha: 0.6)
                  : AppColors.outline.withValues(alpha: 0.55),
              width: _isHovered ? 1.2 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.caramel.withValues(alpha: 0.12)
                    : AppColors.shadow.withValues(alpha: 0.03),
                blurRadius: _isHovered ? 14 : 5,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Top glowing accent indicator on hover
              Positioned(
                top: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  height: 2.5,
                  width: _isHovered ? (widget.isMobile ? 32.0 : 44.0) : 0.0,
                  decoration: BoxDecoration(
                    color: AppColors.caramel,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      if (_isHovered)
                        BoxShadow(
                          color: AppColors.caramel.withValues(alpha: 0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                    ],
                  ),
                ),
              ),

              // Card main content: Row layout
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.isMobile ? 8 : 10,
                  horizontal: widget.isMobile ? 8 : 12,
                ),
                child: Row(
                  children: [
                    // Beveled icon squircle with spring scale animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      width: iconBoxSize,
                      height: iconBoxSize,
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? AppColors.caramel.withValues(alpha: 0.12)
                            : AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.caramel.withValues(alpha: 0.35)
                              : AppColors.outlineVariant,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isHovered
                                ? AppColors.caramel.withValues(alpha: 0.12)
                                : AppColors.espresso.withValues(alpha: 0.03),
                            blurRadius: _isHovered ? 6 : 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedScale(
                          scale: _isHovered ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutBack,
                          child: Icon(
                            widget.icon,
                            color: _isHovered
                                ? AppColors.caramel
                                : AppColors.espresso,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widget.isMobile ? 8 : 12),
                    // Skill name in Expanded
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.inter(
                          fontSize: widget.isMobile ? 11.5 : 13.0,
                          fontWeight: _isHovered
                              ? FontWeight.w700
                              : FontWeight.w600,
                          letterSpacing: -0.2,
                          height: 1.25,
                          color: _isHovered
                              ? AppColors.caramel
                              : AppColors.espresso,
                        ),
                        child: Text(
                          widget.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: widget.isMobile ? 6 : 8),
                    // Percent badge
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.isMobile ? 6 : 8,
                        vertical: widget.isMobile ? 2.5 : 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? AppColors.caramel.withValues(alpha: 0.14)
                            : AppColors.warmBeige.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _isHovered
                              ? AppColors.caramel.withValues(alpha: 0.35)
                              : AppColors.outlineVariant,
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        '${(widget.level * 100).toInt()}%',
                        style: GoogleFonts.inter(
                          fontSize: widget.isMobile ? 10.5 : 11.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: _isHovered
                              ? AppColors.caramel
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

