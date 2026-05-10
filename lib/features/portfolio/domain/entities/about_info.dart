/// Domain entity for the About Me section.
/// No Flutter imports — domain layer must stay pure Dart.
class AboutInfo {
  const AboutInfo({
    required this.title,
    required this.description1,
    required this.description2,
    required this.technologies,
    required this.experienceYears,
    required this.projectsCount,
    required this.technologiesCount,
    required this.clientsCount,
  });

  final String title;
  final String description1;
  final String description2;
  final List<String> technologies;
  final int experienceYears;
  final int projectsCount;
  final int technologiesCount;
  final int clientsCount;
}
