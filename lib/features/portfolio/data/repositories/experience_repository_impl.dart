import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/experience.dart';
import '../../domain/repositories/experience_repository.dart';
import '../models/experience_model.dart';

/// Supabase implementation of [ExperienceRepository].
class ExperienceRepositoryImpl implements ExperienceRepository {
  const ExperienceRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Experience>> getExperiences() async {
    try {
      final response = await _client
          .from('experiences')
          .select()
          .order('id', ascending: true);

      return (response as List<dynamic>)
          .map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch experiences: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching experiences: $e');
    }
  }
}
