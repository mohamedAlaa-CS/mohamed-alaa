import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_projects_use_case.dart';
import 'project_state.dart';

/// Fetches and exposes the list of portfolio projects.
class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this._getProjects) : super(const ProjectInitial());

  final GetProjectsUseCase _getProjects;

  Future<void> fetchProjects() async {
    emit(const ProjectLoading());
    try {
      final projects = await _getProjects();
      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError(e.toString()));
    }
  }
}
