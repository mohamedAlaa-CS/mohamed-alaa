import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/widgets/outlined_button_widget.dart';
import '../../domain/entities/profile.dart';

/// Hero section – two-column layout with gradient heading,
/// bio, CTA buttons, and animated abstract illustration.
class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.profile,
    this.onViewProjects,
    this.onContactMe,
  });

  final Profile profile;
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactMe;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;

    return Container(
      //constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 24,
        vertical: isDesktop ? 80 : 60,
      ),
      child: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideUp,
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _HeroContent(
                      profile: widget.profile,
                      onViewProjects: widget.onViewProjects,
                      onContactMe: widget.onContactMe,
                    )),
                    const SizedBox(width: 60),
                    Expanded(child: _HeroIllustration()),
                  ],
                )
              : Column(
                  children: [
                    _HeroContent(
                      profile: widget.profile,
                      onViewProjects: widget.onViewProjects,
                      onContactMe: widget.onContactMe,
                      isMobile: true,
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      height: 280,
                      child: _HeroIllustration(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.profile,
    this.onViewProjects,
    this.onContactMe,
    this.isMobile = false,
  });

  final Profile profile;
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactMe;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.primaryPurple.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            '👋 Welcome to my portfolio',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Name
        GradientText(
          "Hi, I'm\n${profile.name}",
          style: AppTextStyles.displayLarge.copyWith(
            fontSize: isMobile ? 40 : 64,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 12),
        // Role
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              profile.role,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primaryCyan,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Bio
        Text(
          profile.bio,
          style: AppTextStyles.bodyLarge,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 36),
        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            GradientButton(
              text: 'View Projects',
              icon: Icons.rocket_launch_outlined,
              onPressed: onViewProjects ?? () {},
            ),
            OutlinedButtonWidget(
              text: 'Contact Me',
              icon: Icons.mail_outline_rounded,
              onPressed: onContactMe ?? () {},
            ),
          ],
        ),
      ],
    );
  }
}

/// Abstract animated illustration with floating shapes and icons.
class _HeroIllustration extends StatefulWidget {
  @override
  State<_HeroIllustration> createState() => _HeroIllustrationState();
}

class _HeroIllustrationState extends State<_HeroIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final value = _floatController.value;
        return SizedBox(
          height: 400,
          child: Stack(
            alignment: Alignment.center,
          children: [
            // Glowing purple circle
            Positioned(
              top: 20 + math.sin(value * math.pi * 2) * 15,
              right: 30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryPurple.withValues(alpha: 0.3),
                      AppColors.primaryPurple.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Glowing cyan circle
            Positioned(
              bottom: 40 + math.cos(value * math.pi * 2) * 12,
              left: 20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryCyan.withValues(alpha: 0.25),
                      AppColors.primaryCyan.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Center code block card
            Positioned(
              top: 40 + math.sin(value * math.pi * 2) * 8,
              child: _FloatingCodeCard(),
            ),
            // Flutter icon
            Positioned(
              top: 10 + math.cos(value * math.pi * 2 + 1) * 10,
              left: 40,
              child: _FloatingIcon(
                icon: Icons.flutter_dash,
                color: AppColors.primaryCyan,
                size: 40,
              ),
            ),
            // Dart icon
            Positioned(
              bottom: 30 + math.sin(value * math.pi * 2 + 2) * 12,
              right: 30,
              child: _FloatingIcon(
                icon: Icons.code_rounded,
                color: AppColors.primaryPurple,
                size: 36,
              ),
            ),
            // Firebase icon
            Positioned(
              top: 80 + math.cos(value * math.pi * 2 + 3) * 8,
              right: 10,
              child: _FloatingIcon(
                icon: Icons.local_fire_department_rounded,
                color: AppColors.tertiary,
                size: 32,
              ),
            ),
          ],
        ));
      },
    );
  }
}

class _FloatingCodeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryPurple.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F57),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF28C840),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: AppTextStyles.labelSmall.copyWith(
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.8,
              ),
              children: [
                TextSpan(
                  text: 'class ',
                  style: TextStyle(color: AppColors.primaryPurple),
                ),
                TextSpan(
                  text: 'Developer ',
                  style: TextStyle(color: AppColors.primaryCyan),
                ),
                const TextSpan(text: '{\n'),
                TextSpan(
                  text: '  final ',
                  style: TextStyle(color: AppColors.primaryPurple),
                ),
                const TextSpan(text: 'name = '),
                TextSpan(
                  text: "'Mohamed'",
                  style: TextStyle(color: AppColors.tertiary),
                ),
                const TextSpan(text: ';\n'),
                TextSpan(
                  text: '  final ',
                  style: TextStyle(color: AppColors.primaryPurple),
                ),
                const TextSpan(text: 'skills = '),
                TextSpan(
                  text: "'Flutter'",
                  style: TextStyle(color: AppColors.tertiary),
                ),
                const TextSpan(text: ';\n}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    required this.icon,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}
