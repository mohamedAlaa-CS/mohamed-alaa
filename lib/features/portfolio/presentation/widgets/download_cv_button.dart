import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/file_downloader/file_downloader.dart';
import '../../../../core/widgets/gradient_button.dart';

/// Interactive CTA button to download the CV / resume file to the user's device.
/// Matches the portfolio's bespoke editorial design language.
class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({
    super.key,
    this.onPressed,
    this.cvUrl,
    this.height = 48,
  });

  final VoidCallback? onPressed;
  final String? cvUrl;
  final double height;

  Future<void> _handleDownload(BuildContext context) async {
    if (onPressed != null) {
      onPressed!();
      return;
    }

    final targetUrl = (cvUrl != null && cvUrl!.trim().isNotEmpty)
        ? cvUrl!.trim()
        : AppConstants.cvUrl;

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Downloading CV...'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    try {
      await FileDownloader.downloadFile(
        targetUrl,
        filename: 'Mohamed_Alaa_CV.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading CV: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      text: 'Download CV',
      icon: Icons.download_rounded,
      height: height,
      onPressed: () => _handleDownload(context),
    );
  }
}
