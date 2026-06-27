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
  }

  @override
  State<ProfileWizard> createState() => _ProfileWizardState();
}

class _ProfileWizardState extends State<ProfileWizard> {
  static const _maxSteps = 3;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _jsonTextFieldController;

  int _activePage = 0;

  @override
  void initState() {
    super.initState();
    _jsonTextFieldController = TextEditingController();
  }

  void _onStepContinue() {
    if (_activePage == 2) {
      if (!_formKey.currentState!.validate()) return;
      BlocProvider.of<ProfileCubit>(context).loadProfile(_jsonTextFieldController.text);
    }

    if (_activePage == _maxSteps) return Navigator.pop(context);

    setState(() {
      if (_activePage < _maxSteps) _activePage++;
    });
  }

  String? _validateJson(String? input) {
    if (input == null) return null;
    if (input.isEmpty) return '';

    if (RepositoryProvider.of<WarframeRepository>(context).verifyUserData(input)) {
      return null;
    }

    return context.l10n.inventoriaInputError;
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (_, details) => _StepsControls(details, _maxSteps),
      currentStep: _activePage,
      onStepContinue: _onStepContinue,
      onStepCancel: () => setState(() => _activePage--),
      steps: [
        Step(
          isActive: _activePage == 0,
          title: Text(context.l10n.inventoriaStepOneTitle),
          content: Text('${context.l10n.inventoriaStepOne(faqPage, discordInvite)}\n\n${context.l10n.legalese}'),
        ),
        Step(
          isActive: _activePage == 1,
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
          isActive: _activePage == 2,
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
          isActive: _activePage == _maxSteps,
          title: Text(context.l10n.inventoriaStepFourTitle),
          content: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileUpdating) return const WarframeSpinner();
              if (state is ProfileFailure) return Center(child: Text(context.l10n.inventoriaProfileError));

              if (state is ProfileSuccessful) {
                // At this point user data is verified and non null
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),

                  title: Text(state.profile.username),
                  subtitle: Text(context.l10n.itemRankSubtitle(state.profile.masteryRank)),
                );
              }

              return const SizedBox.shrink();
            },
          ),
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

class _StepsControls extends StatelessWidget {
  const _StepsControls(this.details, this.maxSteps);

  final ControlsDetails details;
  final int maxSteps;

  @override
  Widget build(BuildContext context) {
    final locale = MaterialLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          if (details.stepIndex > 0)
            OutlinedButton(onPressed: details.onStepCancel, child: Text(locale.backButtonTooltip)),
          if (details.stepIndex < maxSteps)
            FilledButton(
              onPressed: details.onStepContinue,
              child: Text(locale.continueButtonLabel),
            ),
          if (details.stepIndex == maxSteps)
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccessful) {
                  return FilledButton(
                    onPressed: details.onStepContinue,
                    child: Text(locale.okButtonLabel),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
