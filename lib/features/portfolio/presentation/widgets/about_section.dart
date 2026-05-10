import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../domain/entities/about_info.dart';
import '../cubit/about_cubit.dart';
import '../cubit/about_state.dart';

/// About Me section with bio text and animated statistic cards.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;

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
              isDesktop: isDesktop,
            ),
        };
      },
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({
    required this.aboutInfo,
    required this.isDesktop,
  });

  final AboutInfo aboutInfo;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
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
                Expanded(child: _AboutText(aboutInfo: aboutInfo)),
                const SizedBox(width: 48),
                Expanded(child: _StatsGrid(aboutInfo: aboutInfo, isDesktop: true)),
              ],
            )
          else
            Column(
              children: [
                _AboutText(aboutInfo: aboutInfo),
                const SizedBox(height: 32),
                _StatsGrid(aboutInfo: aboutInfo, isDesktop: false),
              ],
            ),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText({required this.aboutInfo});

  final AboutInfo aboutInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aboutInfo.title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          aboutInfo.description1,
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          aboutInfo.description2,
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: aboutInfo.technologies
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
  const _StatsGrid({required this.aboutInfo, required this.isDesktop});

  final AboutInfo aboutInfo;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final stats = [
      (
        value: '${aboutInfo.projectsCount}+',
        label: 'Projects',
        icon: Icons.folder_outlined,
      ),
      (
        value: '${aboutInfo.experienceYears}+',
        label: 'Years Exp',
        icon: Icons.timeline_outlined,
      ),
      (
        value: '${aboutInfo.technologiesCount}+',
        label: 'Technologies',
        icon: Icons.code_outlined,
      ),
      (
        value: '${aboutInfo.clientsCount}+',
        label: 'Clients',
        icon: Icons.people_outlined,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: isDesktop ? 1.3 : 1.5,
      children: stats
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
