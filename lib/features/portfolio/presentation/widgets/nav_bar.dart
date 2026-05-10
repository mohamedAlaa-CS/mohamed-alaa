import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Glassmorphism navigation bar with logo and responsive menu.
class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.onNavItemTap,
    required this.scrollOffset,
  });

  final void Function(int index) onNavItemTap;
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < AppConstants.tabletBreakpoint;

    return Container(
      decoration: BoxDecoration(
        color: scrollOffset > 50
            ? AppColors.background.withValues(alpha: 0.85)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: scrollOffset > 50
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.transparent,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: scrollOffset > 50 ? 20 : 0,
            sigmaY: scrollOffset > 50 ? 20 : 0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: 16,
            ),
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Row(
              children: [
                // Logo
                _Logo(),
                const Spacer(),
                // Nav Links or Menu Button
                if (isMobile)
                  _MobileMenuButton(onNavItemTap: onNavItemTap)
                else
                  _DesktopNavLinks(onNavItemTap: onNavItemTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        AppConstants.name,
        style: AppTextStyles.headlineMedium.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DesktopNavLinks extends StatelessWidget {
  const _DesktopNavLinks({required this.onNavItemTap});

  final void Function(int index) onNavItemTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(AppConstants.navItems.length, (index) {
        return _NavLinkItem(
          label: AppConstants.navItems[index],
          onTap: () => onNavItemTap(index),
        );
      }),
    );
  }
}

class _NavLinkItem extends StatefulWidget {
  const _NavLinkItem({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.navLink.copyWith(
                  color: _isHovered
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isHovered ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.onNavItemTap});

  final void Function(int index) onNavItemTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.onSurface),
      onPressed: () => _showMobileMenu(context),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(AppConstants.navItems.length, (index) {
                  return ListTile(
                    title: Text(
                      AppConstants.navItems[index],
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onNavItemTap(index);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
