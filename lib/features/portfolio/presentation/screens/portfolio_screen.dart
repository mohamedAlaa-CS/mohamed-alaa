import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

/// Main scrollable portfolio page assembling all sections.
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late final ScrollController _scrollController;
  double _scrollOffset = 0;

  // Keys for each section to enable scroll-to navigation
  final _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController()..addListener(() {
          setState(() => _scrollOffset = _scrollController.offset);
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading() || ProfileInitial() => const _LoadingView(),
          ProfileError(:final message) => _ErrorView(
            message: message,
            onRetry: () => context.read<ProfileCubit>().fetchProfile(),
          ),
          ProfileLoaded(:final profile) => _PortfolioContent(
            profile: profile,
            scrollController: _scrollController,
            scrollOffset: _scrollOffset,
            sectionKeys: _sectionKeys,
            onScrollToSection: _scrollToSection,
          ),
        };
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Full portfolio layout (shown when profile is loaded)
// ─────────────────────────────────────────────────────────────────────────────

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent({
    required this.profile,
    required this.scrollController,
    required this.scrollOffset,
    required this.sectionKeys,
    required this.onScrollToSection,
  });

  final Profile profile;
  final ScrollController scrollController;
  final double scrollOffset;
  final List<GlobalKey> sectionKeys;
  final void Function(int) onScrollToSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorative elements
          const _BackgroundDecoration(),
          // Scrollable content
          CustomScrollView(
            controller: scrollController,
            slivers: [
              // Top padding for navbar
              const SliverToBoxAdapter(child: SizedBox(height: 72)),
              // Hero
              SliverToBoxAdapter(
                child: Center(
                  child: HeroSection(
                    profile: profile,
                    onViewProjects: () => onScrollToSection(2),
                    onContactMe: () => onScrollToSection(4),
                  ),
                ),
              ),
              // About
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: sectionKeys[0],
                  child: const AboutSection(),
                ),
              ),
              // Skills
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: sectionKeys[1],
                  child: const SkillsSection(),
                ),
              ),
              // Projects
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: sectionKeys[2],
                  child: const ProjectsSection(),
                ),
              ),
              // Experience
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: sectionKeys[3],
                  child: const ExperienceSection(),
                ),
              ),
              // Contact
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: sectionKeys[4],
                  child: ContactSection(profile: profile),
                ),
              ),
              // Footer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: FooterSection(
                    profile: profile,
                    onNavItemTap: onScrollToSection,
                  ),
                ),
              ),
            ],
          ),
          // Fixed Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: NavBar(
                onNavItemTap: onScrollToSection,
                scrollOffset: scrollOffset,
              ),
            ),
          ),
          // Floating back-to-top button
          if (scrollOffset > 400)
            Positioned(
              bottom: 32,
              right: 32,
              child: _BackToTopButton(
                onTap:
                    () => scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading / Error views
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.onSurfaceVariant,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load profile',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionWrapper extends StatelessWidget {
  const _SectionWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.sectionSpacing),
      child: Center(child: child),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple glow top-left
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryPurple.withValues(alpha: 0.08),
                  AppColors.primaryPurple.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Cyan glow bottom-right
        Positioned(
          top: 400,
          right: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryCyan.withValues(alpha: 0.05),
                  AppColors.primaryCyan.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Dot grid pattern overlay
        Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.03)
          ..style = PaintingStyle.fill;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BackToTopButton extends StatefulWidget {
  const _BackToTopButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient45,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withValues(
                  alpha: _isHovered ? 0.5 : 0.25,
                ),
                blurRadius: _isHovered ? 20 : 12,
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
