/// States emitted by [ContactCubit].
sealed class ContactState {
  const ContactState();
}

final class ContactInitial extends ContactState {
  const ContactInitial();
}

final class ContactSending extends ContactState {
  const ContactSending();
}

final class ContactSuccess extends ContactState {
  const ContactSuccess();
}

final class ContactError extends ContactState {
  const ContactError(this.message);
  final String message;
}
