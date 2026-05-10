import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_heading.dart';

/// About Me section with bio text and animated statistic cards.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;

    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
      child: Column(
        children: [
          const SectionHeading(
            title: 'About Me',
            subtitle: 'Get to know me and my journey',
          ),
          const SizedBox(height: 48),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AboutText()),
                const SizedBox(width: 48),
                Expanded(child: _StatsGrid(isDesktop: true)),
              ],
            )
          else
            Column(
              children: [
                _AboutText(),
                const SizedBox(height: 32),
                _StatsGrid(isDesktop: false),
              ],
            ),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm a passionate Flutter developer focused on building beautiful, "
          "performant, and scalable mobile applications.",
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'With a strong foundation in clean architecture and modern state '
          'management patterns, I specialize in creating cross-platform '
          'applications that deliver exceptional user experiences.',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'My expertise spans across Firebase integration, REST API '
          'consumption, real-time features, offline-first development, '
          'payment gateway integration, and responsive design principles.',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              ['Flutter', 'Dart', 'Firebase', 'Clean Arch', 'Cubit/BLoC']
                  .map(
                    (tech) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryCyan.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.primaryCyan.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primaryCyan,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.isDesktop});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: isDesktop ? 1.3 : 1.5,
      children:
          AppConstants.stats
              .map(
                (s) => _StatCard(value: s.value, label: s.label, icon: s.icon),
              )
              .toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value;
  final String label;
  final IconData icon;

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: GlassCard(
          borderColor: _isHovered ? AppColors.primaryPurple : null,
          borderOpacity: _isHovered ? 0.3 : 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primaryPurple,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.value, style: AppTextStyles.headlineLarge),
                ),
              ),
              const SizedBox(height: 4),
              Text(widget.label, style: AppTextStyles.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
