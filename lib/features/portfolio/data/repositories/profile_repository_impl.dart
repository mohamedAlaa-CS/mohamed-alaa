import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

/// Supabase implementation of [ProfileRepository].
/// Fetches the first row from the `profiles` table.
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<Profile> getProfile() async {
    try {
      final response = await _client.from('profiles').select().maybeSingle();
      log(response.toString(),name: 'profile');
      if (response == null) {
        throw Exception('Profile not found');
      }

      return ProfileModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch profile: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching profile: $e');
    }
  }
}
