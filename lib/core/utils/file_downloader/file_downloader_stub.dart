import 'package:url_launcher/url_launcher.dart';

/// Non-web fallback for downloading files.
Future<void> downloadFilePlatform(
  String url, {
  String filename = 'Mohamed_Alaa_CV.pdf',
}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
