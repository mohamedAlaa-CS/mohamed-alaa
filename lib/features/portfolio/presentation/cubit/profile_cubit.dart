import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_profile_use_case.dart';
import 'profile_state.dart';

/// Fetches and exposes the portfolio owner's profile data.
/// Depends only on [GetProfileUseCase] — never on the repository directly.
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile) : super(const ProfileInitial());

  final GetProfileUseCase _getProfile;

  Future<void> fetchProfile() async {
    emit(const ProfileLoading());
    try {
      final profile = await _getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
