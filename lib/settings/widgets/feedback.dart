import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(context: context, builder: (context) => const UserFeedback());
  }

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      SentryId? id;
      if (Sentry.lastEventId != const SentryId.empty()) id = Sentry.lastEventId;

      Sentry.captureFeedback(SentryFeedback(message: _controller.text, associatedEventId: id));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: _controller,
                maxLines: 4,
                maxLength: 250,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: context.l10n.userFeedbackLabelText,
                ),
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return context.l10n.userFeedbackErrorText;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [FilledButton(onPressed: _onSubmit, child: Text(context.l10n.userFeedbackSubmitButton))],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
