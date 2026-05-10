import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contact_message.dart';
import '../../domain/use_cases/send_message_use_case.dart';
import 'contact_state.dart';

/// Handles sending contact form messages via EmailJS.
class ContactCubit extends Cubit<ContactState> {
  ContactCubit(this._sendMessage) : super(const ContactInitial());

  final SendMessageUseCase _sendMessage;

  Future<void> send({
    required String name,
    required String email,
    required String message,
  }) async {
    emit(const ContactSending());
    try {
      await _sendMessage(ContactMessage(
        name: name,
        email: email,
        message: message,
      ));
      emit(const ContactSuccess());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  /// Resets the form state so the user can send another message.
  void reset() => emit(const ContactInitial());
}
