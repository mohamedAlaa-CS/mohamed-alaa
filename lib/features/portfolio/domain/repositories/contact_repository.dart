import '../entities/contact_message.dart';

abstract interface class ContactRepository {
  Future<void> sendMessage(ContactMessage message);
}
