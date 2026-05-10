import '../../domain/entities/profile.dart';

/// Data model that maps the Supabase `profiles` table row to a [Profile] entity.
/// Assumed column names: name, role, bio, email, github_url, linkedin_url
class ProfileModel extends Profile {
  const ProfileModel({
    required super.name,
    required super.role,
    required super.bio,
    required super.email,
    required super.githubUrl,
    required super.linkedinUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      email: json['email'] as String? ?? '',
      githubUrl: json['github_url'] as String? ?? '',
      linkedinUrl: json['linkedin_url'] as String? ?? '',
    );
  }
}
