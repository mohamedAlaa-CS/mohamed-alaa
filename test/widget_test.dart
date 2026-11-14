import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mohamed_alaa/core/constants/app_constants.dart';
import 'package:mohamed_alaa/core/theme/app_colors.dart';
import 'package:mohamed_alaa/core/utils/file_downloader/file_downloader.dart';
import 'package:mohamed_alaa/features/portfolio/data/models/about_info_model.dart';
import 'package:mohamed_alaa/features/portfolio/presentation/widgets/download_cv_button.dart';
import 'package:mohamed_alaa/features/portfolio/presentation/widgets/view_cv_button.dart';

void main() {
  test('AppColors brand palette verification', () {
    // Assert Editorial Light palette values: Paper Ivory, Espresso, Caramel, TextBody
    expect(AppColors.background, const Color(0xFFFAF7F2));
    expect(AppColors.espresso, const Color(0xFF1A120B));
    expect(AppColors.onSurface, const Color(0xFF1A120B));
    expect(AppColors.caramel, const Color(0xFFB45309));
  });

  test('AppConstants cvUrl is defined and valid', () {
    expect(AppConstants.cvUrl.isNotEmpty, isTrue);
    expect(Uri.tryParse(AppConstants.cvUrl)?.hasScheme, isTrue);
  });

  test('AboutInfoModel.fromJson correctly parses cv_url from Supabase data', () {
    final json = {
      'title': 'Senior Flutter Developer',
      'description_1': 'Bio 1',
      'description_2': 'Bio 2',
      'technologies': ['Flutter', 'Dart'],
      'experience_years': 3,
      'projects_count': 10,
      'technologies_count': 12,
      'clients_count': 5,
      'cv_url':
          'https://supabase.example.com/storage/v1/object/public/cv/my_cv.pdf',
    };

    final model = AboutInfoModel.fromJson(json);

    expect(model.cvUrl,
        'https://supabase.example.com/storage/v1/object/public/cv/my_cv.pdf');
    expect(model.title, 'Senior Flutter Developer');
  });

  testWidgets(
      'DownloadCvButton renders with label and icon, and invokes callback on tap',
      (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DownloadCvButton(
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Download CV'), findsOneWidget);
    expect(find.byIcon(Icons.download_rounded), findsOneWidget);

    await tester.tap(find.byType(DownloadCvButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets(
      'ViewCvButton renders with label and icon, and invokes callback on tap',
      (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ViewCvButton(
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('View CV'), findsOneWidget);
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

    await tester.tap(find.byType(ViewCvButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  test('FileDownloader.resolveDownloadUrl converts Google Drive view link to export download link', () {
    const driveViewUrl =
        'https://drive.google.com/file/d/1_ABC123xyz-test/view?usp=sharing';
    final resolved = FileDownloader.resolveDownloadUrl(driveViewUrl);
    expect(resolved,
        'https://drive.google.com/uc?export=download&id=1_ABC123xyz-test');

    const directUrl =
        'https://supabase.example.com/storage/v1/object/public/cv/my_cv.pdf';
    expect(FileDownloader.resolveDownloadUrl(directUrl), directUrl);
  });
}
