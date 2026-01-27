import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/cubit/profile_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_repository/warframe_repository.dart';

class ProfileWizard extends StatefulWidget {
  const ProfileWizard({super.key});

  static Future<void> startWizard(BuildContext context) async {
    final data = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => const ProfileWizard(),
    );

    if (!context.mounted || data == null) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.syncingInfoText)));

    try {
      await BlocProvider.of<ProfileCubit>(context).saveProfile(data);
    } on Exception {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.profileSyncError)));
    }
  }

  @override
  State<ProfileWizard> createState() => _ProfileWizardState();
}

class _ProfileWizardState extends State<ProfileWizard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _jsonTextFieldController;

  static const _maxSteps = 3;

  UserData? _user;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _jsonTextFieldController = TextEditingController();
  }

  void _onStepContinue() {
    if (_currentPage == 2) {
      if (!_formKey.currentState!.validate()) return;

      final user = RepositoryProvider.of<WarframeRepository>(context).convertUserData(_jsonTextFieldController.text);
      setState(() {
        _user = user;
        _currentPage++;
      });
    } else if (_currentPage == _maxSteps) {
      Navigator.pop(context, _jsonTextFieldController.text);
    } else {
      setState(() => _currentPage++);
    }
  }

  Widget _controlsBuilder(BuildContext context, ControlsDetails details) {
    final locale = MaterialLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,

        children: [
          if (details.stepIndex > 0)
            OutlinedButton(onPressed: details.onStepCancel, child: Text(locale.backButtonTooltip)),
          if (details.stepIndex < _maxSteps)
            FilledButton(
              onPressed: details.onStepContinue,
              child: Text(locale.continueButtonLabel),
            ),
          if (details.stepIndex == _maxSteps)
            FilledButton(
              onPressed: details.onStepContinue,
              child: Text(locale.okButtonLabel),
            ),
        ],
      ),
    );
  }

  String? _validateJson(String? input) {
    if (input == null) return null;
    if (input.isEmpty) return 'JSON value cannot be empty';

    try {
      RepositoryProvider.of<WarframeRepository>(context).convertUserData(input);
      return null;
    } on Exception {
      return 'Input was incorret or user is not signed in';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: _controlsBuilder,
      currentStep: _currentPage,
      onStepContinue: _onStepContinue,
      onStepCancel: () => setState(() => _currentPage--),
      steps: [
        Step(
          title: Text(context.l10n.inventoriaStepOneTitle),
          content: Text('${context.l10n.inventoriaStepOne(faqPage, discordInvite)}\n\n${context.l10n.legalese}'),
        ),
        Step(
          title: Text(context.l10n.inventoriaStepTwoTitle),
          content: Column(
            spacing: 24,
            children: [
              Text(context.l10n.inventoriaStepTwoDescription),
              Center(
                child: FilledButton.tonal(
                  onPressed: () => warframeLogin.launchLink(context),
                  child: Text(context.l10n.inventoriaStepTwoTitle),
                ),
              ),
            ],
          ),
        ),
        Step(
          title: Text(context.l10n.inventoriaStepThreeTitle),
          content: Column(
            mainAxisSize: .min,
            spacing: 24,
            children: [
              Text(context.l10n.inventoriaStepThreeDescription),
              FilledButton.tonal(
                onPressed: () => warframeUserData.launchLink(context),
                child: Text(context.l10n.inventoriaStepThreeButtonLabel),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  maxLines: 6,
                  validator: _validateJson,
                  controller: _jsonTextFieldController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: context.l10n.inventoriaStepThreeTextLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          title: Text(context.l10n.inventoriaStepFourTitle),
          content: _user != null
              ? ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  leading: CircleAvatar(
                    radius: 25,
                    foregroundImage: CachedNetworkImageProvider(_user!.avatar),
                  ),
                  title: Text(_user!.username),
                  subtitle: Text(context.l10n.itemRankSubtitle(_user!.masteryRank)),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _jsonTextFieldController.dispose();
    super.dispose();
  }
}
