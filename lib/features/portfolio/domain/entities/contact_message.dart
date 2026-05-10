/// Domain entity representing a contact message.
/// No Flutter imports — domain layer must stay pure Dart.
class ContactMessage {
  const ContactMessage({
    required this.name,
    required this.email,
    required this.message,
  });

  final String name;
  final String email;
  final String message;
}
