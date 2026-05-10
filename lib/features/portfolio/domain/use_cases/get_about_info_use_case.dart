import '../entities/about_info.dart';
import '../repositories/about_repository.dart';

/// Fetches About Me content from the data source.
class GetAboutInfoUseCase {
  const GetAboutInfoUseCase(this._repository);

  final AboutRepository _repository;

  Future<AboutInfo> call() => _repository.getAboutInfo();
}
