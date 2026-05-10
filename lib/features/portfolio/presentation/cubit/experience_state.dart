import '../../domain/entities/experience.dart';

/// States emitted by [ExperienceCubit].
sealed class ExperienceState {
  const ExperienceState();
}

final class ExperienceInitial extends ExperienceState {
  const ExperienceInitial();
}

final class ExperienceLoading extends ExperienceState {
  const ExperienceLoading();
}

final class ExperienceLoaded extends ExperienceState {
  const ExperienceLoaded(this.experiences);
  final List<Experience> experiences;
}

final class ExperienceError extends ExperienceState {
  const ExperienceError(this.message);
  final String message;
}
