import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_experiences_use_case.dart';
import 'experience_state.dart';

/// Fetches and exposes the list of experience timeline entries.
class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit(this._getExperiences) : super(const ExperienceInitial());

  final GetExperiencesUseCase _getExperiences;

  Future<void> fetchExperiences() async {
    emit(const ExperienceLoading());
    try {
      final experiences = await _getExperiences();
      emit(ExperienceLoaded(experiences));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }
}
