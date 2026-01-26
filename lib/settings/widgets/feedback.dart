import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/utils/feedback_forms.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(context: context, isScrollControlled: true, builder: (context) => const UserFeedback());
  }

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FeedbackForm _feedbackForm;
  late TextEditingController _emailController;
  late TextEditingController _feedbackController;

  void _onEmailChanged() {
    setState(() {
      _feedbackForm = _feedbackForm.copyWith(email: EmailInput.dirty(_emailController.text));
    });
  }

  void _onFeedbackChanged() {
    setState(() {
      _feedbackForm = _feedbackForm.copyWith(feedback: FeedbackInput.dirty(_feedbackController.text));
    });
  }

  @override
  void initState() {
    super.initState();
    _feedbackForm = FeedbackForm();
    _emailController = TextEditingController()..addListener(_onEmailChanged);
    _feedbackController = TextEditingController()..addListener(_onFeedbackChanged);
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _feedbackForm = _feedbackForm.copyWith(status: .inProgress);
    });

    try {
      SentryId? id;
      if (Sentry.lastEventId != const SentryId.empty()) id = Sentry.lastEventId;

      final contactEmail = _emailController.text.isEmpty ? null : _emailController.text;
      id = await Sentry.captureFeedback(
        SentryFeedback(contactEmail: contactEmail, message: _feedbackController.text, associatedEventId: id),
      );
      _feedbackForm = _feedbackForm.copyWith(status: .success);
    } on Exception {
      _feedbackForm = _feedbackForm.copyWith(status: .failure);
    }

    if (!mounted) return;

    setState(() {});

    FocusScope.of(context).unfocus();

    final successSnackBar = SnackBar(content: Text(context.l10n.sendFeedbackSubmissionSuccessful));
    final failureSnackBar = SnackBar(content: Text(context.l10n.sendFeedbackSubmissionFailure));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_feedbackForm.status.isSuccess ? successSnackBar : failureSnackBar);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                titleTextStyle: context.textTheme.titleLarge,
                title: Text(context.l10n.sendFeedbackTitle),
                subtitle: Text(context.l10n.sendFeedbackDescription),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  labelText: context.l10n.sendFeedbackLabelText,
                  hintText: context.l10n.sendFeedbackHintText,
                  helperText: context.l10n.sendFeedbackHelperText,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (input) =>
                    input?.isNotEmpty ?? false ? _feedbackForm.email.validator(input ?? '')?.text() : null,
              ),
              Flexible(
                child: TextFormField(
                  controller: _feedbackController,
                  maxLines: 4,
                  maxLength: 500,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: context.l10n.userFeedbackLabelText,
                  ),
                  validator: (input) => _feedbackForm.feedback.validator(input ?? '')?.text(),
                ),
              ),
              Text(
                context.l10n.legalese,
                textAlign: .center,
                style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onSurface.withAlpha(195)),
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }
}
