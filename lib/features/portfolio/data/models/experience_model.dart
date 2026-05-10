import '../../domain/entities/experience.dart';

/// Maps a Supabase `experiences` table row to an [Experience] entity.
class ExperienceModel extends Experience {
  const ExperienceModel({
    required super.id,
    required super.role,
    required super.company,
    required super.period,
    required super.description,
    required super.highlights,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      company: json['company'] as String? ?? '',
      period: json['period'] as String? ?? '',
      description: json['description'] as String? ?? '',
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
