import '../../domain/entities/project.dart';

/// Maps a Supabase `projects` table row to a [Project] entity.
class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.tags,
    required super.color,
    super.githubUrl,
    super.playStoreUrl,
    super.appStoreUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      color: json['color'] as String? ?? '#6C63FF',
      githubUrl: json['github_url'] as String?,
      playStoreUrl: json['play_store_url'] as String?,
      appStoreUrl: json['app_store_url'] as String?,
    );
  }
}
