import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

/// Fetches the portfolio owner's profile from the data source.
class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Profile> call() => _repository.getProfile();
}
