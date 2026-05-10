import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/about_info.dart';
import '../../domain/repositories/about_repository.dart';
import '../models/about_info_model.dart';

/// Supabase implementation of [AboutRepository].
class AboutRepositoryImpl implements AboutRepository {
  const AboutRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<AboutInfo> getAboutInfo() async {
    try {
      final response =
          await _client.from('about_me').select().maybeSingle();

      if (response == null) {
        throw Exception('About info not found');
      }

      return AboutInfoModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch about info: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching about info: $e');
    }
  }
}
