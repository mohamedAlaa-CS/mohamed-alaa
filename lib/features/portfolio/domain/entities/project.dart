/// Domain entity for a portfolio project.
/// No Flutter imports — domain layer must stay pure Dart.
class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.color,
    this.githubUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final String color; // stored as hex string e.g. '#6C63FF'
  final String? githubUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
}
