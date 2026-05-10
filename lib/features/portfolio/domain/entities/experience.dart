/// Domain entity for a single experience timeline entry.
/// No Flutter imports — domain layer must stay pure Dart.
class Experience {
  const Experience({
    required this.id,
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.highlights,
  });

  final String id;
  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> highlights;
}
