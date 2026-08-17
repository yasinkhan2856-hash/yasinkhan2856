import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  bool sending = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (!formKey.currentState!.validate() || sending) return;
    final formId = PortfolioData.formspreeFormId;
    if (formId.startsWith('YOUR_')) {
      final subject = Uri.encodeComponent(
        'Portfolio enquiry from ${nameController.text.trim()}',
      );
      final body = Uri.encodeComponent(
        'Name: ${nameController.text.trim()}\n'
        'Email: ${emailController.text.trim()}\n\n'
        '${messageController.text.trim()}',
      );
      openExternalUrl(
        context,
        'mailto:${PortfolioData.email}?subject=$subject&body=$body',
      );
      return;
    }

    setState(() => sending = true);
    try {
      final response = await http
          .post(
            Uri.parse('https://formspree.io/f/$formId'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': nameController.text.trim(),
              '_replyto': emailController.text.trim(),
              'email': emailController.text.trim(),
              '_subject': 'Portfolio enquiry from ${nameController.text.trim()}',
              'message': messageController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        nameController.clear();
        emailController.clear();
        messageController.clear();
        await showDialog<void>(
          context: context,
          builder: (_) => _StatusDialog(
            icon: Icons.check_circle_outline,
            title: 'You have sent the message',
            subtitle: 'Thanks for reaching out! I will get back to you soon.',
            accent: Colors.green,
          ),
        );
      } else {
        await showDialog<void>(
          context: context,
          builder: (_) => _StatusDialog(
            icon: Icons.error_outline,
            title: 'Something went wrong',
            subtitle: 'Your message could not be sent. Please try again.',
            accent: Colors.redAccent,
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => _StatusDialog(
          icon: Icons.error_outline,
          title: 'Something went wrong',
          subtitle: 'Check your internet connection and try again.',
          accent: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  @override
  Widget build(BuildContext context) => SectionBlock(
    child: ScrollReveal(
      scrollController: widget.scrollController,
      child: Column(
        children: [
          const SectionTitleBox(title: 'Contact'),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, c) {
              final info = _ContactInfo(onSend: sendMessage);
              final form = _ContactForm(
                formKey: formKey,
                nameController: nameController,
                emailController: emailController,
                messageController: messageController,
                sending: sending,
                onSubmit: sendMessage,
              );
              return c.maxWidth > 680
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 9, child: info),
                        const SizedBox(width: 48),
                        Expanded(flex: 11, child: form),
                      ],
                    )
                  : Column(children: [info, const SizedBox(height: 40), form]);
            },
          ),
        ],
      ),
    ),
  );
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({required this.onSend});
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Let\'s build something useful.',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 16),
      Text(
        'Available for an immediate start, remote work, and relocation. Reach out about a role or project.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 28),
      _ContactRow(
        icon: FontAwesomeIcons.github,
        label: 'GitHub',
        value: 'github.com/yasinkhan2856-hash',
        url: PortfolioData.github,
      ),
      _ContactRow(
        icon: FontAwesomeIcons.linkedinIn,
        label: 'LinkedIn',
        value: 'linkedin.com/in/yasinkhan2856',
        url: PortfolioData.linkedin,
      ),
      _ContactRow(
        icon: FontAwesomeIcons.instagram,
        label: 'Instagram',
        value: 'instagram.com/yasin_khan_285',
        url: PortfolioData.instagram,
      ),
      _ContactRow(
        icon: FontAwesomeIcons.snapchat,
        label: 'Snapchat',
        value: 'snapchat.com/add/yasin_k1284',
        url: PortfolioData.snapchat,
      ),
      _ContactRow(
        icon: Icons.mail_outline,
        label: 'Email',
        value: PortfolioData.email,
        url: 'mailto:${PortfolioData.email}',
      ),
      _ContactRow(
        icon: Icons.phone_outlined,
        label: 'Phone',
        value: PortfolioData.phone,
        url: 'tel:${PortfolioData.phone}',
      ),
      _ContactRow(
        icon: Icons.location_on_outlined,
        label: 'Location',
        value: PortfolioData.location,
        url: null,
      ),

      const SizedBox(height: 24),
      const Text(
        'Languages: English (Professional) , Urdu , Pastho',
        style: TextStyle(color: AppColors.muted, fontSize: 13),
      ),
    ],
  );
}

class _ContactRow extends StatefulWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.url,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? url;

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => hovered = true),
    onExit: (_) => setState(() => hovered = false),
    child: GestureDetector(
      onTap: widget.url != null
          ? () => openExternalUrl(context, widget.url!)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: hovered && widget.url != null
              ? AppColors.accent.withValues(alpha: .06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: hovered ? AppColors.accent : AppColors.muted,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 9,
                      letterSpacing: 1.2,
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.value,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: hovered && widget.url != null
                          ? AppColors.accent
                          : AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.url != null)
              Icon(
                Icons.arrow_outward,
                size: 16,
                color: hovered ? AppColors.accent : AppColors.border,
              ),
          ],
        ),
      ),
    ),
  );
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.sending,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool sending;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => HoverCard(
    child: Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Your Name'),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Your Email'),
            validator: (v) => v == null || !v.contains('@')
                ? 'Please enter a valid email'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: messageController,
            decoration: const InputDecoration(labelText: 'Your Message'),
            minLines: 5,
            maxLines: 7,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter a message' : null,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: sending
                ? FilledButton.icon(
                    onPressed: null,
                    icon: const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    label: const Text('Sending...'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                    ),
                  )
                : PremiumButton(
                    label: 'Send Message',
                    icon: Icons.send_outlined,
                    onPressed: onSubmit,
                  ),
          ),
        ],
      ),
    ),
  );
}

class _StatusDialog extends StatelessWidget {
  const _StatusDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: .12),
            ),
            child: Icon(icon, size: 34, color: accent),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(
              backgroundColor: accent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}
