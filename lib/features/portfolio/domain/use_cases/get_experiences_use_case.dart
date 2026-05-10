import '../entities/experience.dart';
import '../repositories/experience_repository.dart';

/// Returns all experience entries ordered by id.
class GetExperiencesUseCase {
  const GetExperiencesUseCase(this._repository);

  final ExperienceRepository _repository;

  Future<List<Experience>> call() => _repository.getExperiences();
}
