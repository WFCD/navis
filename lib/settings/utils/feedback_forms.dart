import 'package:formz/formz.dart';

class FeedbackForm with FormzMixin {
  FeedbackForm({
    EmailInput? email,
    FeedbackInput? feedback,
    this.status = FormzSubmissionStatus.initial,
  }) : email = email ?? EmailInput.pure(),
       feedback = feedback ?? FeedbackInput.pure();

  final EmailInput email;
  final FeedbackInput feedback;
  final FormzSubmissionStatus status;

  FeedbackForm copyWith({
    EmailInput? email,
    FeedbackInput? feedback,
    FormzSubmissionStatus? status,
  }) {
    return FeedbackForm(
      email: email ?? this.email,
      feedback: feedback ?? this.feedback,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email];
}

enum EmailValidationError { invalid, empty }

extension EmailValidationExtension on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.invalid:
        return 'Please ensure the email entered is valid';
      case EmailValidationError.empty:
        return 'Please enter an email';
    }
  }
}

class EmailInput extends FormzInput<String, EmailValidationError> with FormzInputErrorCacheMixin {
  EmailInput.pure([super.value = '']) : super.pure();

  EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!_emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }

    return null;
  }
}

enum FeedbackValidationError { invalid, empty }

extension FeedbackValidationErrorEx on FeedbackValidationError {
  String text() {
    switch (this) {
      case FeedbackValidationError.invalid:
        return '''Password must be at least 8 characters and contain at least one letter and number''';
      case FeedbackValidationError.empty:
        return 'Please enter some feedback';
    }
  }
}

class FeedbackInput extends FormzInput<String, FeedbackValidationError> with FormzInputErrorCacheMixin {
  FeedbackInput.pure([super.value = '']) : super.pure();

  FeedbackInput.dirty([super.value = '']) : super.dirty();

  @override
  FeedbackValidationError? validator(String value) {
    if (value.isEmpty) {
      return FeedbackValidationError.empty;
    }

    return null;
  }
}
