import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
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
    _scrollController = ScrollController()
      ..addListener(() {
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorative elements
          const _BackgroundDecoration(),
          // Scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Top padding for navbar
              const SliverToBoxAdapter(
                child: SizedBox(height: 72),
              ),
              // Hero
              SliverToBoxAdapter(
                child: Center(
                  child: HeroSection(
                    onViewProjects: () => _scrollToSection(2),
                    onContactMe: () => _scrollToSection(4),
                  ),
                ),
              ),
              // About
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: _sectionKeys[0],
                  child: const AboutSection(),
                ),
              ),
              // Skills
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: _sectionKeys[1],
                  child: const SkillsSection(),
                ),
              ),
              // Projects
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: _sectionKeys[2],
                  child: const ProjectsSection(),
                ),
              ),
              // Experience
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: _sectionKeys[3],
                  child: const ExperienceSection(),
                ),
              ),
              // Contact
              SliverToBoxAdapter(
                child: _SectionWrapper(
                  key: _sectionKeys[4],
                  child: const ContactSection(),
                ),
              ),
              // Footer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: FooterSection(onNavItemTap: _scrollToSection),
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
                onNavItemTap: _scrollToSection,
                scrollOffset: _scrollOffset,
              ),
            ),
          ),
          // Floating back-to-top button
          if (_scrollOffset > 400)
            Positioned(
              bottom: 32,
              right: 32,
              child: _BackToTopButton(
                onTap: () => _scrollController.animateTo(
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
        Positioned.fill(
          child: CustomPaint(painter: _DotGridPainter()),
        ),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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
