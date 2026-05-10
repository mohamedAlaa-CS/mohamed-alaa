import '../../domain/entities/about_info.dart';

/// States emitted by [AboutCubit].
sealed class AboutState {
  const AboutState();
}

final class AboutInitial extends AboutState {
  const AboutInitial();
}

final class AboutLoading extends AboutState {
  const AboutLoading();
}

final class AboutLoaded extends AboutState {
  const AboutLoaded(this.aboutInfo);
  final AboutInfo aboutInfo;
}

final class AboutError extends AboutState {
  const AboutError(this.message);
  final String message;
}
