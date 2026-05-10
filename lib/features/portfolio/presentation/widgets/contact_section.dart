import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../domain/entities/profile.dart';
import '../cubit/contact_cubit.dart';
import '../cubit/contact_state.dart';

/// Contact section with info cards and a message form.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppConstants.desktopBreakpoint;
    final isTablet = width >= AppConstants.tabletBreakpoint;

    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
      child: Column(
        children: [
          const SectionHeading(
            title: 'Get In Touch',
            subtitle: 'Have a project in mind? Let\'s work together!',
          ),
          const SizedBox(height: 48),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactInfo(profile: profile)),
                const SizedBox(width: 48),
                const Expanded(child: _ContactForm()),
              ],
            )
          else if (isTablet)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _ContactInfo(profile: profile),
                ),
                const SizedBox(width: 32),
                const Expanded(flex: 3, child: _ContactForm()),
              ],
            )
          else
            Column(
              children: [
                _ContactInfo(profile: profile),
                const SizedBox(height: 32),
                const _ContactForm(),
              ],
            ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something amazing together",
          style: AppTextStyles.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "I'm always open to discussing new projects, creative ideas, "
          "or opportunities to be part of your vision.",
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: 32),
        _ContactTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: profile.email,
          onTap: () => _launch('mailto:${profile.email}'),
        ),
        const SizedBox(height: 16),
        _ContactTile(
          icon: Icons.code_rounded,
          label: 'GitHub',
          value: profile.githubUrl,
          onTap: () => _launch(profile.githubUrl),
        ),
        const SizedBox(height: 16),
        _ContactTile(
          icon: Icons.person_outlined,
          label: 'LinkedIn',
          value: profile.name,
          onTap: () => _launch(profile.linkedinUrl),
        ),
      ],
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ContactTile extends StatefulWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  State<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<_ContactTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          borderColor: _isHovered ? AppColors.primaryCyan : null,
          borderOpacity: _isHovered ? 0.3 : 0.08,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryCyan.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primaryCyan,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label, style: AppTextStyles.labelSmall),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onSend() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ContactCubit>().send(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          message: _messageController.text.trim(),
        );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
        switch (state) {
          case ContactSuccess():
            _clearForm();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Message sent successfully! 🎉'),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            context.read<ContactCubit>().reset();
          case ContactError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to send: $message'),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            context.read<ContactCubit>().reset();
          default:
            break;
        }
      },
      builder: (context, state) {
        final isSending = state is ContactSending;

        return GlassCard(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Send a Message', style: AppTextStyles.headlineMedium),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  enabled: !isSending,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
                    prefixIcon: Icon(Icons.person_outline, size: 20),
                  ),
                  style: const TextStyle(color: AppColors.onSurface),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  enabled: !isSending,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
                    prefixIcon: Icon(Icons.email_outlined, size: 20),
                  ),
                  style: const TextStyle(color: AppColors.onSurface),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  enabled: !isSending,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Your Message',
                    labelStyle: TextStyle(color: AppColors.onSurfaceVariant),
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Icon(Icons.message_outlined, size: 20),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.onSurface),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                isSending
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : GradientButton(
                        text: 'Send Message',
                        icon: Icons.send_rounded,
                        onPressed: _onSend,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
