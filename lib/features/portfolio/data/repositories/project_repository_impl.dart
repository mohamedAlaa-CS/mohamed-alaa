import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../models/project_model.dart';

/// Supabase implementation of [ProjectRepository].
class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Project>> getProjects() async {
    try {
      final response = await _client
          .from('projects')
          .select()
          .order('sort_order', ascending: true);

      return (response as List<dynamic>)
          .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch projects: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching projects: $e');
    }
  }
}
