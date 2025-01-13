import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({super.key, this.username});

  final String? username;

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        final username = context.select((UserSettingsCubit cubit) {
          final state = cubit.state;
          if (state is! UserSettingsSuccess) return null;

          return state.username;
        });

        return UsernameInput(username: username);
      },
    );
  }

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  bool get _isValid {
    return _controller.text.isNotEmpty && _controller.text.length >= 4;
  }

  void _onSubmit([String? value]) {
    final username = value ?? _controller.text;

    BlocProvider.of<UserSettingsCubit>(context).updateUsername(username);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(context.l10n.syncingInfoText)));

    BlocProvider.of<ArsenalCubit>(context).updateArsenal(username);
    Navigator.pop(context);
  }

  void _onClear() {
    BlocProvider.of<UserSettingsCubit>(context).updateUsername(null);
  }

  @override
  Widget build(BuildContext context) {
    final ml10n = MaterialLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            // usernames are all chaotic so don't let the OS make
            // it harder on the user
            autocorrect: false,
            enableSuggestions: false,
            onChanged: (value) => setState(() {}),
            onSubmitted: (value) => _onSubmit(_controller.text),
            decoration: InputDecoration(
              filled: true,
              hintText: widget.username ?? context.l10n.enterUsernameHintText,
              fillColor: context.theme.colorScheme.onSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Gaps.gap12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: _onClear,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.theme.colorScheme.error,
                    side: BorderSide(color: context.theme.colorScheme.error),
                  ),
                  child: Text(context.l10n.clearUsernameButtonLabel),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.l10n.cancelText),
                ),
                FilledButton(
                  onPressed: _isValid ? _onSubmit : null,
                  child: Text(ml10n.saveButtonLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
