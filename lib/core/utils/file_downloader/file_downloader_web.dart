// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

/// Web implementation for downloading files directly to the device's Downloads directory.
Future<void> downloadFilePlatform(
  String url, {
  String filename = 'Mohamed_Alaa_CV.pdf',
}) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        response.bodyBytes.isNotEmpty) {
      final blob = html.Blob([response.bodyBytes], 'application/pdf');
      final blobUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: blobUrl)
        ..setAttribute('download', filename)
        ..style.display = 'none';
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(blobUrl);
      return;
    }
  } catch (_) {
    // If CORS or network prevents direct byte fetching, fall back to anchor click
  }

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..target = '_blank';
  html.document.body?.children.add(anchor);
  anchor.click();
  html.document.body?.children.remove(anchor);
}
