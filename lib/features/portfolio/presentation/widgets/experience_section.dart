import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../domain/entities/experience.dart';
import '../cubit/experience_cubit.dart';
import '../cubit/experience_state.dart';

/// Experience timeline section with vertical line connector.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;

    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) {
        return switch (state) {
          ExperienceLoading() || ExperienceInitial() => const Center(
              child: Padding(
                padding: EdgeInsets.all(48),
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          ExperienceError(:final message) => Center(
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
                          context.read<ExperienceCubit>().fetchExperiences(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ExperienceLoaded(:final experiences) => _ExperienceContent(
              experiences: experiences,
              isDesktop: isDesktop,
            ),
        };
      },
    );
  }
}

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent({
    required this.experiences,
    required this.isDesktop,
  });

  final List<Experience> experiences;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
      child: Column(
        children: [
          const SectionHeading(
            title: 'Experience',
            subtitle: 'My professional journey',
          ),
          const SizedBox(height: 48),
          ...List.generate(experiences.length, (index) {
            return _TimelineEntry(
              experience: experiences[index],
              isLast: index == experiences.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatefulWidget {
  const _TimelineEntry({required this.experience, required this.isLast});
  final Experience experience;
  final bool isLast;

  @override
  State<_TimelineEntry> createState() => _TimelineEntryState();
}

class _TimelineEntryState extends State<_TimelineEntry> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line + dot
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _isHovered ? AppColors.primaryGradient : null,
                      color: _isHovered
                          ? null
                          : AppColors.primaryPurple.withValues(alpha: 0.4),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: AppColors.primaryPurple
                                    .withValues(alpha: 0.4),
                                blurRadius: 10,
                              ),
                            ]
                          : [],
                    ),
                  ),
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primaryPurple.withValues(alpha: 0.4),
                              AppColors.primaryPurple.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Content card
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primaryPurple.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryCyan.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        exp.period,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primaryCyan,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(exp.role, style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      exp.company,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(exp.description, style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 16),
                    // Highlights
                    ...exp.highlights.map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child:
                                  Text(h, style: AppTextStyles.bodyMedium),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
