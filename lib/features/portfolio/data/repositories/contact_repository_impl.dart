import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../domain/entities/contact_message.dart';
import '../../domain/repositories/contact_repository.dart';

/// EmailJS REST API implementation of [ContactRepository].
/// Calls https://api.emailjs.com/api/v1.0/email/send directly — no SDK needed.
class ContactRepositoryImpl implements ContactRepository {
  const ContactRepositoryImpl({
    required this.serviceId,
    required this.templateId,
    required this.publicKey,
  });

  final String serviceId;
  final String templateId;
  final String publicKey;

  static const _endpoint =
      'https://api.emailjs.com/api/v1.0/email/send';

  @override
  Future<void> sendMessage(ContactMessage message) async {
    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'from_name': message.name,
            'from_email': message.email,
            'message': message.message,
            'subject': 'New Contact from Portfolio',
          },
        }),
      );

      if (response.statusCode != 200) {
        log(
          'EmailJS error ${response.statusCode}: ${response.body}',
          name: 'contact',
        );
        throw Exception('EmailJS error (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      log(e.toString(), name: 'contact');
      rethrow;
    }
  }
}
