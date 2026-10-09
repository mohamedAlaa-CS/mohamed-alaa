import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// A premium animated loading screen shown while the portfolio data loads.
///
/// Features:
/// - Pulsing gradient logo ring
/// - Animated shimmer name text
/// - Smooth progress bar with gradient
/// - Floating ambient particles
/// - Typing-style status text
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _progressController;
  late final AnimationController _particleController;
  late final AnimationController _fadeInController;

  late final Animation<double> _pulseAnimation;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Fade in the entire screen
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeOut,
    );
    _fadeInController.forward();

    // Pulsing ring animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Progress bar animation (loops to show continuous loading)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Particle drift animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    _particleController.dispose();
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Stack(
          children: [
            // Ambient gradient glows
            const _AmbientGlows(),

            // Floating particles
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) => CustomPaint(
                size: MediaQuery.sizeOf(context),
                painter: _ParticlePainter(
                  progress: _particleController.value,
                ),
              ),
            ),

            // Main centered content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pulsing logo ring
                  _PulsingLogoRing(animation: _pulseAnimation),

                  const SizedBox(height: 40),

                  // Name text with shimmer
                  _ShimmerText(controller: _progressController),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Progress indicator
                  _AnimatedProgressBar(animation: _progressAnimation),

                  const SizedBox(height: 20),

                  // Loading status text
                  _LoadingStatusText(controller: _progressController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Ambient background glows
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientGlows extends StatelessWidget {
  const _AmbientGlows();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-left purple glow
        Positioned(
          top: -200,
          left: -200,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryPurple.withValues(alpha: 0.12),
                  AppColors.primaryPurple.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Bottom-right cyan glow
        Positioned(
          bottom: -200,
          right: -200,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryCyan.withValues(alpha: 0.08),
                  AppColors.primaryCyan.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Center subtle glow
        Center(
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryPurple.withValues(alpha: 0.04),
                  AppColors.primaryPurple.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pulsing logo ring with code icon
// ─────────────────────────────────────────────────────────────────────────────

class _PulsingLogoRing extends StatelessWidget {
  const _PulsingLogoRing({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final scale = 0.95 + (animation.value * 0.05);
        final glowOpacity = 0.15 + (animation.value * 0.25);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: glowOpacity),
                  blurRadius: 40,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: AppColors.primaryCyan.withValues(
                    alpha: glowOpacity * 0.6,
                  ),
                  blurRadius: 60,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    AppColors.primaryPurple,
                    AppColors.primaryCyan,
                    AppColors.primaryPurple.withValues(alpha: 0.3),
                    AppColors.primaryCyan,
                    AppColors.primaryPurple,
                  ],
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      'MA',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shimmer text effect for the name
// ─────────────────────────────────────────────────────────────────────────────

class _ShimmerText extends StatelessWidget {
  const _ShimmerText({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            final shimmerPosition = controller.value * 3 - 1;
            return LinearGradient(
              colors: const [
                AppColors.onSurface,
                AppColors.primaryCyan,
                AppColors.primaryPurple,
                AppColors.onSurface,
              ],
              stops: [
                (shimmerPosition - 0.3).clamp(0.0, 1.0),
                (shimmerPosition - 0.1).clamp(0.0, 1.0),
                (shimmerPosition + 0.1).clamp(0.0, 1.0),
                (shimmerPosition + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: const Text(
            'Mohamed Alaa',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated gradient progress bar
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedProgressBar extends StatelessWidget {
  const _AnimatedProgressBar({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizedBox(
          width: 200,
          height: 3,
          child: CustomPaint(
            painter: _ProgressBarPainter(progress: animation.value),
          ),
        );
      },
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  const _ProgressBarPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Track
    final trackPaint = Paint()
      ..color = AppColors.surfaceContainerHigh
      ..style = PaintingStyle.fill;

    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(2),
    );
    canvas.drawRRect(trackRect, trackPaint);

    // Sliding indicator (moves across the bar)
    final indicatorWidth = size.width * 0.4;
    final indicatorStart = (size.width + indicatorWidth) * progress -
        indicatorWidth;

    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          AppColors.primaryPurple,
          AppColors.primaryCyan,
        ],
      ).createShader(
        Rect.fromLTWH(indicatorStart, 0, indicatorWidth, size.height),
      )
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.clipRRect(trackRect);

    final indicatorRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(indicatorStart, 0, indicatorWidth, size.height),
      const Radius.circular(2),
    );
    canvas.drawRRect(indicatorRect, gradientPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ProgressBarPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Typing-style loading status text
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingStatusText extends StatelessWidget {
  const _LoadingStatusText({required this.controller});

  final AnimationController controller;

  static const _messages = [
    'Initializing portfolio',
    'Loading projects',
    'Preparing experience',
    'Almost ready',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final messageIndex =
            (controller.value * _messages.length).floor() % _messages.length;
        final dotCount = ((controller.value * 12).floor() % 3) + 1;
        final dots = '.' * dotCount;

        return Text(
          '${_messages[messageIndex]}$dots',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
            letterSpacing: 1,
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Floating particle effect painter
// ─────────────────────────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.progress});

  final double progress;

  static final List<_Particle> _particles = List.generate(
    30,
    (i) => _Particle(
      x: Random(i).nextDouble(),
      y: Random(i * 7).nextDouble(),
      size: 1.0 + Random(i * 3).nextDouble() * 2.0,
      speed: 0.3 + Random(i * 5).nextDouble() * 0.7,
      opacity: 0.05 + Random(i * 11).nextDouble() * 0.15,
      isPurple: Random(i * 13).nextBool(),
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in _particles) {
      final x = (particle.x * size.width +
              progress * particle.speed * size.width * 0.3) %
          size.width;
      final y = (particle.y * size.height -
              progress * particle.speed * size.height * 0.15) %
          size.height;

      final paint = Paint()
        ..color = (particle.isPurple
                ? AppColors.primaryPurple
                : AppColors.primaryCyan)
            .withValues(alpha: particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _Particle {
  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.isPurple,
  });

  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final bool isPurple;
}
