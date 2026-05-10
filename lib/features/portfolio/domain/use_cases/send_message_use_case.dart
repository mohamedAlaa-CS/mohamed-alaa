import '../entities/contact_message.dart';
import '../repositories/contact_repository.dart';

/// Sends a contact message via the data source (EmailJS).
class SendMessageUseCase {
  const SendMessageUseCase(this._repository);

  final ContactRepository _repository;

  Future<void> call(ContactMessage message) => _repository.sendMessage(message);
}
