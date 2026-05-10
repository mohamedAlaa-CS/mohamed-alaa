/// Domain entity representing the portfolio owner's personal profile.
/// No Flutter imports — domain layer must stay pure Dart.
class Profile {
  const Profile({
    required this.name,
    required this.role,
    required this.bio,
    required this.email,
    required this.githubUrl,
    required this.linkedinUrl,
  });

  final String name;
  final String role;
  final String bio;
  final String email;
  final String githubUrl;
  final String linkedinUrl;
}
