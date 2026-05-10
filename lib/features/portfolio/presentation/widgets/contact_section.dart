import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/section_heading.dart';

/// Contact section with info cards and a message form.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
            title: 'Get In Touch',
            subtitle: 'Have a project in mind? Let\'s work together!',
          ),
          const SizedBox(height: 48),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactInfo()),
                const SizedBox(width: 48),
                Expanded(child: _ContactForm()),
              ],
            )
          else
            Column(
              children: [
                _ContactInfo(),
                const SizedBox(height: 32),
                _ContactForm(),
              ],
            ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something amazing together",
          style: AppTextStyles.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "I'm always open to discussing new projects, creative ideas, "
          "or opportunities to be part of your vision.",
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 32),
        _ContactTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: AppConstants.email,
          onTap: () => _launch('mailto:${AppConstants.email}'),
        ),
        const SizedBox(height: 16),
        _ContactTile(
          icon: Icons.code_rounded,
          label: 'GitHub',
          value: 'mohamedAlaa-CS',
          onTap: () => _launch(AppConstants.githubUrl),
        ),
        const SizedBox(height: 16),
        _ContactTile(
          icon: Icons.person_outlined,
          label: 'LinkedIn',
          value: 'Mohamed Alaa',
          onTap: () => _launch(AppConstants.linkedinUrl),
        ),
      ],
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ContactTile extends StatefulWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  State<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<_ContactTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          borderColor: _isHovered ? AppColors.primaryCyan : null,
          borderOpacity: _isHovered ? 0.3 : 0.08,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryCyan.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primaryCyan,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.label, style: AppTextStyles.labelSmall),
                  const SizedBox(height: 2),
                  Text(
                    widget.value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Send a Message', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 24),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Your Name',
              labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
              prefixIcon: Icon(Icons.person_outline, size: 20),
            ),
            style: TextStyle(color: AppColors.onSurface),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Your Email',
              labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
            style: TextStyle(color: AppColors.onSurface),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Your Message',
              labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
              alignLabelWithHint: true,
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Icon(Icons.message_outlined, size: 20),
              ),
            ),
            style: TextStyle(color: AppColors.onSurface),
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Send Message',
            icon: Icons.send_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
