import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../../core/widgets/tech_tag.dart';
import '../../domain/entities/project.dart';
import '../cubit/project_cubit.dart';
import '../cubit/project_state.dart';

/// Featured projects section with responsive card grid.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.tabletBreakpoint;

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return switch (state) {
          ProjectLoading() || ProjectInitial() => const Center(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
          ProjectError(:final message) => Center(
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
                    onPressed:
                        () => context.read<ProjectCubit>().fetchProjects(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          ProjectLoaded(:final projects) => _ProjectsContent(
            projects: projects,
            isDesktop: isDesktop,
          ),
        };
      },
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  const _ProjectsContent({required this.projects, required this.isDesktop});

  final List<Project> projects;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
      child: Column(
        children: [
          const SectionHeading(
            title: 'Featured Projects',
            subtitle: 'Some of my recent work',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isDesktop ? 1.6 : 1.7,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _ProjectCard(project: projects[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});
  final Project project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Color get _accentColor {
    final hex = widget.project.color.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final accent = _accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                _isHovered
                    ? accent.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.06),
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.15),
                      blurRadius: 25,
                      spreadRadius: -3,
                    ),
                  ]
                  : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with colored accent bar
            Row(
              children: [
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project.title,
                    style: AppTextStyles.headlineMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Description
            Expanded(
              child: Text(
                project.description,
                style: AppTextStyles.bodyMedium,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            // Tags
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children:
                  project.tags
                      .map((tag) => TechTag(tag, color: accent))
                      .toList(),
            ),
            const SizedBox(height: 16),
            // Action buttons
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                if (project.githubUrl != null)
                  _LinkButton(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    color: accent,
                    url: project.githubUrl!,
                  ),
                if (project.playStoreUrl != null)
                  _LinkButton(
                    icon: Icons.android_rounded,
                    label: 'Play Store',
                    color: accent,
                    url: project.playStoreUrl!,
                  ),
                if (project.appStoreUrl != null)
                  _LinkButton(
                    icon: Icons.apple_rounded,
                    label: 'App Store',
                    color: accent,
                    url: project.appStoreUrl!,
                  ),
                if (project.githubUrl == null &&
                    project.playStoreUrl == null &&
                    project.appStoreUrl == null)
                  _LinkButton(
                    icon: Icons.lock_outline_rounded,
                    label: 'Private Project',
                    color: AppColors.onSurfaceVariant,
                    url: null,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.url,
  });

  final IconData icon;
  final String label;
  final Color color;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: url != null ? () => _launchUrl(url!) : null,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.labelLarge.copyWith(color: color)),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
