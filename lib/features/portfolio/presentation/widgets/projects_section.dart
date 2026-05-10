import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../../core/widgets/tech_tag.dart';

/// Featured projects section with responsive card grid.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              childAspectRatio: isDesktop ? 1.3 : 1.5,
            ),
            itemCount: AppConstants.projects.length,
            itemBuilder: (context, index) {
              return _ProjectCard(project: AppConstants.projects[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});
  final ProjectData project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? project.color.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: project.color.withValues(alpha: 0.15),
                    blurRadius: 25,
                    spreadRadius: -3,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with colored accent
            Row(
              children: [
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: project.color,
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
            const SizedBox(height: 16),
            // Description
            Expanded(
              child: Text(
                project.description,
                style: AppTextStyles.bodyMedium,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.tags
                  .map((tag) => TechTag(tag, color: project.color))
                  .toList(),
            ),
            const SizedBox(height: 16),
            // Action
            InkWell(
              onTap: () => _launchUrl(project.githubUrl),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.open_in_new_rounded,
                    color: project.color,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'View on GitHub',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: project.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
