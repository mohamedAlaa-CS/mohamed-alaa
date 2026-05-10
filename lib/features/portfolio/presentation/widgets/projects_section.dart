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

/// Featured projects section — fully responsive grid, no fixed aspect ratio.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () =>
                        context.read<ProjectCubit>().fetchProjects(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          ProjectLoaded(:final projects) => _ProjectsContent(
            projects: projects,
          ),
        };
      },
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  const _ProjectsContent({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive column count:
        // < 600  → 1 column
        // 600–1000 → 2 columns
        // > 1000  → 3 columns
        final int columns;
        if (width >= AppConstants.desktopBreakpoint) {
          columns = 3;
        } else if (width >= AppConstants.mobileBreakpoint) {
          columns = 2;
        } else {
          columns = 1;
        }

        final double hPad = width >= AppConstants.tabletBreakpoint ? 40 : 24;
        const double gap = 24;

        final cardWidth =
            (width - hPad * 2 - gap * (columns - 1)) / columns;

        return Container(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Column(
            children: [
              const SectionHeading(
                title: 'Featured Projects',
                subtitle: 'Some of my recent work',
              ),
              const SizedBox(height: 48),
              // Wrap-based grid: cards size to their content, no clipping
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: projects
                    .map(
                      (project) => SizedBox(
                        width: cardWidth,
                        child: _ProjectCard(project: project),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
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
  bool _isExpanded = false;

  Color get _accentColor {
    if (widget.project.color.isEmpty) return AppColors.primaryCyan;
    final hex = widget.project.color.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final accent = _accentColor;
    final needsReadMore = project.description.length > 100 || project.tags.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            Matrix4.identity()..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? accent.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.15),
                    blurRadius: 25,
                    spreadRadius: -3,
                  ),
                ]
              : [],
        ),
        // Column sizes to content — no Expanded needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header: accent bar + title
            Row(
              children: [
                Container(
                  width: 4,
                  height: 28,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Description and Tags wrapped in AnimatedSize
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.description,
                    style: AppTextStyles.bodyMedium,
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded ? null : TextOverflow.ellipsis,
                  ),
                  if (_isExpanded && project.tags.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: project.tags
                          .map((tag) => TechTag(tag, color: accent))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            if (needsReadMore) ...[
              const SizedBox(height: 12),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'Read Less' : 'Read More',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: accent,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Divider
            Divider(
              color: Colors.white.withValues(alpha: 0.06),
              height: 1,
            ),
            const SizedBox(height: 12),
            // Action buttons
            Wrap(
              spacing: 16,
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

class _LinkButton extends StatefulWidget {
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
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final canTap = widget.url != null;

    return MouseRegion(
      cursor:
          canTap ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: canTap ? () => _launchUrl(widget.url!) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: _isHovered && canTap
                ? widget.color.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered && canTap
                  ? widget.color.withValues(alpha: 0.4)
                  : widget.color.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 15),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style:
                    AppTextStyles.labelLarge.copyWith(color: widget.color),
              ),
            ],
          ),
        ),
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
