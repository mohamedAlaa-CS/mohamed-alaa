import '../entities/about_info.dart';

abstract interface class AboutRepository {
  Future<AboutInfo> getAboutInfo();
}
