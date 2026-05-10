import '../entities/profile.dart';

/// Contract for fetching the portfolio owner's profile.
/// Implemented in the data layer.
abstract interface class ProfileRepository {
  Future<Profile> getProfile();
}
