import '../entities/project.dart';
import '../repositories/project_repository.dart';

/// Returns all projects ordered by id.
class GetProjectsUseCase {
  const GetProjectsUseCase(this._repository);

  final ProjectRepository _repository;

  Future<List<Project>> call() => _repository.getProjects();
}
