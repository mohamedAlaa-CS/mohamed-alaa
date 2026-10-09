import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../domain/entities/about_info.dart';
import '../cubit/about_cubit.dart';
import '../cubit/about_state.dart';

/// About Me section with editorial bio card and interactive statistic cards.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        return switch (state) {
          AboutLoading() || AboutInitial() => const Center(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
          AboutError(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.onSurfaceVariant,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        context.read<AboutCubit>().fetchAboutInfo(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          AboutLoaded(:final aboutInfo) => _AboutContent(
            aboutInfo: aboutInfo,
            screenWidth: width,
          ),
        };
      },
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.aboutInfo, required this.screenWidth});

  final AboutInfo aboutInfo;
  final double screenWidth;

  bool get _isDesktop => screenWidth >= AppConstants.desktopBreakpoint;
  bool get _isTablet => screenWidth >= AppConstants.tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final isMobile = screenWidth < AppConstants.mobileBreakpoint;
    final double hPad = isMobile ? 16 : (_isTablet ? 40 : 24);

    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          const SectionHeading(
            title: 'About Me',
            subtitle: 'Get to know me and my journey',
          ),
          SizedBox(height: isMobile ? 28 : 44),
          if (_isDesktop)
            // Desktop: Side-by-side balanced composition
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _AboutText(
                    aboutInfo: aboutInfo,
                    isMobile: false,
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 4,
                  child: _StatsGrid(
                    aboutInfo: aboutInfo,
                    isMobile: false,
                  ),
                ),
              ],
            )
          else if (_isTablet)
            // Tablet: Side-by-side with tighter gap
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _AboutText(
                    aboutInfo: aboutInfo,
                    isMobile: false,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 4,
                  child: _StatsGrid(
                    aboutInfo: aboutInfo,
                    isMobile: false,
                  ),
                ),
              ],
            )
          else
            // Mobile: Stacked gracefully
            Column(
              children: [
                _AboutText(
                  aboutInfo: aboutInfo,
                  isMobile: true,
                ),
                const SizedBox(height: 20),
                _StatsGrid(
                  aboutInfo: aboutInfo,
                  isMobile: true,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _AboutText extends StatefulWidget {
  const _AboutText({
    required this.aboutInfo,
    required this.isMobile,
  });

  final AboutInfo aboutInfo;
  final bool isMobile;

  @override
  State<_AboutText> createState() => _AboutTextState();
}

class _AboutTextState extends State<_AboutText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.isMobile ? 18 : 28),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-heading pill tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
            decoration: BoxDecoration(
              color: AppColors.caramel.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.caramel.withValues(alpha: 0.25),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.terminal_rounded,
                  size: 14,
                  color: AppColors.caramel,
                ),
                const SizedBox(width: 6),
                Text(
                  'BACKGROUND & EXPERIENCE',
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppColors.caramel,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Headline
          Text(
            widget.aboutInfo.title,
            style: GoogleFonts.inter(
              fontSize: widget.isMobile ? 20 : 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              color: AppColors.espresso,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          // Bio content with smooth animation
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.aboutInfo.description1,
                  style: GoogleFonts.inter(
                    fontSize: widget.isMobile ? 14 : 15,
                    fontWeight: FontWeight.w400,
                    height: 1.65,
                    color: AppColors.textBody,
                  ),
                  maxLines: _isExpanded ? null : 4,
                  overflow: _isExpanded ? null : TextOverflow.ellipsis,
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: 14),
                  Text(
                    widget.aboutInfo.description2,
                    style: GoogleFonts.inter(
                      fontSize: widget.isMobile ? 14 : 15,
                      fontWeight: FontWeight.w400,
                      height: 1.65,
                      color: AppColors.textBody,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Expand toggle button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warmBeige.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.outline.withValues(alpha: 0.5),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isExpanded ? 'Show Less' : 'Read Full Story',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.caramel,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.caramel,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          // Technologies chips with accent dots
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.aboutInfo.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warmBeige.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.outlineVariant,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.caramel,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      tech,
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.espresso,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatefulWidget {
  const _StatsGrid({
    required this.aboutInfo,
    required this.isMobile,
  });

  final AboutInfo aboutInfo;
  final bool isMobile;

  @override
  State<_StatsGrid> createState() => _StatsGridState();
}

class _StatsGridState extends State<_StatsGrid> {
  bool _isVisible = false;
  ScrollPosition? _scrollPosition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (_scrollPosition != newPosition) {
      _scrollPosition?.removeListener(_checkVisibility);
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_checkVisibility);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_checkVisibility);
    super.dispose();
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox && renderObject.hasSize && renderObject.attached) {
      final position = renderObject.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.sizeOf(context).height;
      if (position.dy < screenHeight - 30 && position.dy + renderObject.size.height > 0) {
        _scrollPosition?.removeListener(_checkVisibility);
        _scrollPosition = null;
        setState(() => _isVisible = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = [
      (
        count: widget.aboutInfo.projectsCount,
        suffix: '+',
        label: 'Completed Projects',
        icon: Icons.folder_special_outlined,
      ),
      (
        count: widget.aboutInfo.experienceYears,
        suffix: '+',
        label: 'Years Experience',
        icon: Icons.timeline_outlined,
      ),
      (
        count: widget.aboutInfo.technologiesCount,
        suffix: '+',
        label: 'Technologies',
        icon: Icons.code_rounded,
      ),
      (
        count: widget.aboutInfo.clientsCount,
        suffix: '+',
        label: 'Satisfied Clients',
        icon: Icons.groups_outlined,
      ),
    ];

    const double gap = 12;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final cardWidth = (availableWidth - gap) / 2;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: stats.map((s) {
            return SizedBox(
              width: cardWidth,
              child: _StatCard(
                count: s.count,
                suffix: s.suffix,
                label: s.label,
                icon: s.icon,
                isMobile: widget.isMobile,
                isVisible: _isVisible,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _StatCard extends StatefulWidget {
  const _StatCard({
    required this.count,
    required this.suffix,
    required this.label,
    required this.icon,
    required this.isMobile,
    required this.isVisible,
  });

  final int count;
  final String suffix;
  final String label;
  final IconData icon;
  final bool isMobile;
  final bool isVisible;

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final iconBoxSize = widget.isMobile ? 36.0 : 42.0;
    final iconSize = widget.isMobile ? 18.0 : 21.0;

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
            borderRadius: BorderRadius.circular(14),
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
                  width: _isHovered ? 38.0 : 0.0,
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

              // Card content: Left-aligned modern KPI layout
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.isMobile ? 14 : 18,
                  horizontal: widget.isMobile ? 12 : 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top row: Icon on left, trend arrow on right
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          width: iconBoxSize,
                          height: iconBoxSize,
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? AppColors.caramel.withValues(alpha: 0.14)
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
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? AppColors.caramel.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: widget.isMobile ? 14 : 16,
                            color: _isHovered
                                ? AppColors.caramel
                                : AppColors.textMuted.withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.isMobile ? 12 : 16),
                    // High-performance animated counter (zero-lag vsync)
                    _AnimatedCounter(
                      count: widget.count,
                      suffix: widget.suffix,
                      isMobile: widget.isMobile,
                      isHovered: _isHovered,
                      isVisible: widget.isVisible,
                    ),
                    const SizedBox(height: 4),
                    // Stat label
                    Text(
                      widget.label,
                      style: GoogleFonts.inter(
                        fontSize: widget.isMobile ? 11.5 : 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.1,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

/// Dedicated, zero-allocation vsync animated counter.
class _AnimatedCounter extends StatefulWidget {
  const _AnimatedCounter({
    required this.count,
    required this.suffix,
    required this.isMobile,
    required this.isHovered,
    required this.isVisible,
  });

  final int count;
  final String suffix;
  final bool isMobile;
  final bool isHovered;
  final bool isVisible;

  @override
  State<_AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<_AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = IntTween(begin: 0, end: widget.count).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    if (widget.isVisible) {
      _started = true;
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !_started) {
      _started = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pre-cache styles once per build: zero GoogleFonts overhead per animation frame
    final numberStyle = GoogleFonts.inter(
      fontSize: widget.isMobile ? 26 : 34,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.0,
      color: widget.isHovered ? AppColors.caramel : AppColors.espresso,
      height: 1.1,
    );

    final plusStyle = GoogleFonts.inter(
      fontSize: widget.isMobile ? 18 : 24,
      fontWeight: FontWeight.w800,
      color: AppColors.caramel,
      height: 1.1,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('${_animation.value}', style: numberStyle),
            Text(widget.suffix, style: plusStyle),
          ],
        );
      },
    );
  }
}

