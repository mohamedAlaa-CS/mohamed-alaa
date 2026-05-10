import '../../domain/entities/about_info.dart';

/// Maps the Supabase `about_me` table row to an [AboutInfo] entity.
class AboutInfoModel extends AboutInfo {
  const AboutInfoModel({
    required super.title,
    required super.description1,
    required super.description2,
    required super.technologies,
    required super.experienceYears,
    required super.projectsCount,
    required super.technologiesCount,
    required super.clientsCount,
  });

  factory AboutInfoModel.fromJson(Map<String, dynamic> json) {
    return AboutInfoModel(
      title: json['title'] as String? ?? '',
      description1: json['description_1'] as String? ?? '',
      description2: json['description_2'] as String? ?? '',
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      experienceYears: json['experience_years'] as int? ?? 0,
      projectsCount: json['projects_count'] as int? ?? 0,
      technologiesCount: json['technologies_count'] as int? ?? 0,
      clientsCount: json['clients_count'] as int? ?? 0,
    );
  }
}
