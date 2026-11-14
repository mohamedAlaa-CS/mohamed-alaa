import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/outlined_button_widget.dart';

/// Interactive secondary button to preview / view the CV document in browser or viewer.
class ViewCvButton extends StatelessWidget {
  const ViewCvButton({
    super.key,
    this.onPressed,
    this.cvUrl,
    this.height = 48,
  });

  final VoidCallback? onPressed;
  final String? cvUrl;
  final double height;

  Future<void> _handleView(BuildContext context) async {
    if (onPressed != null) {
      onPressed!();
      return;
    }

    final targetUrl = (cvUrl != null && cvUrl!.trim().isNotEmpty)
        ? cvUrl!.trim()
        : AppConstants.cvUrl;
    final uri = Uri.parse(targetUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open CV document.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening CV: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButtonWidget(
      text: 'View CV',
      icon: Icons.visibility_outlined,
      height: height,
      onPressed: () => _handleView(context),
    );
  }
}
