import '../../domain/entities/project.dart';

/// States emitted by [ProjectCubit].
sealed class ProjectState {
  const ProjectState();
}

final class ProjectInitial extends ProjectState {
  const ProjectInitial();
}

final class ProjectLoading extends ProjectState {
  const ProjectLoading();
}

final class ProjectLoaded extends ProjectState {
  const ProjectLoaded(this.projects);
  final List<Project> projects;
}

final class ProjectError extends ProjectState {
  const ProjectError(this.message);
  final String message;
}
