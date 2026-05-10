import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/profile.dart';

/// Footer with copyright, nav links, and social icons.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.profile, this.onNavItemTap});

  final Profile profile;
  final void Function(int index)? onNavItemTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < AppConstants.tabletBreakpoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            constraints:
                const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
            child: isMobile
                ? Column(
                    children: [
                      _Logo(name: profile.name),
                      const SizedBox(height: 20),
                      _NavLinks(onNavItemTap: onNavItemTap),
                      const SizedBox(height: 20),
                      _SocialIcons(profile: profile),
                    ],
                  )
                : Row(
                    children: [
                      _Logo(name: profile.name),
                      const Spacer(),
                      _NavLinks(onNavItemTap: onNavItemTap),
                      const Spacer(),
                      _SocialIcons(profile: profile),
                    ],
                  ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.06),
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} ${profile.name}. Built with Flutter.',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        name,
        style: AppTextStyles.headlineMedium.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _NavLinks extends StatelessWidget {
  const _NavLinks({this.onNavItemTap});
  final void Function(int index)? onNavItemTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(AppConstants.navItems.length, (index) {
        return GestureDetector(
          onTap: () => onNavItemTap?.call(index),
          child: Text(
            AppConstants.navItems[index],
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        );
      }),
    );
  }
}

class _SocialIcons extends StatelessWidget {
  const _SocialIcons({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(
          icon: Icons.code_rounded,
          url: profile.githubUrl,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.person_outline_rounded,
          url: profile.linkedinUrl,
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.email_outlined,
          url: 'mailto:${profile.email}',
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primaryPurple.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryPurple.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppColors.primary : AppColors.onSurfaceVariant,
            size: 20,
          ),
        ),
      ),
    );
  }
}
