import 'file_downloader_stub.dart'
    if (dart.library.html) 'file_downloader_web.dart';

/// Cross-platform utility to trigger file downloads to the user's device.
abstract final class FileDownloader {
  /// Converts Google Drive preview URLs to direct export/download URLs if applicable.
  static String resolveDownloadUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return trimmed;

    final regExp = RegExp(r'drive\.google\.com/file/d/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(trimmed);
    if (match != null) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=download&id=$fileId';
    }
    return trimmed;
  }

  /// Downloads [url] as a file to the user's device.
  static Future<void> downloadFile(
    String url, {
    String filename = 'Mohamed_Alaa_CV.pdf',
  }) {
    final directUrl = resolveDownloadUrl(url);
    return downloadFilePlatform(directUrl, filename: filename);
  }
}
