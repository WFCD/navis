import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile_setup/profile_setup.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_api/warframe_api.dart';

class InventoriaSetup extends StatelessWidget {
  const InventoriaSetup({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final noteStyle = context.textTheme.labelMedium?.copyWith(color: Colors.grey[400]);

    return Stepper(
      currentStep: currentStep,
      onStepContinue: context.read<ProfileSetupCubit>().nextStep,
      onStepCancel: context.read<ProfileSetupCubit>().previousStep,
      onStepTapped: context.read<ProfileSetupCubit>().goToStep,
      controlsBuilder: (context, details) => _StepsControls(details),
      steps: [
        Step(
          isActive: currentStep == 0,
          title: Text(context.l10n.inventoriaStepOneTitle),
          content: Text(context.l10n.inventoriaStepOne(faqPage, discordInvite)),
        ),
        Step(
          title: const Text('Select Platform'),
          content: Column(
            spacing: 24,
            children: [
              DropdownButton<WarframeSupportedPlatform>(
                value: context.watch<ProfileSetupCubit>().state.platform,
                items: const [
                  DropdownMenuItem(value: .pc, child: Text('PC')),
                  DropdownMenuItem(value: .xb1, child: Text('Xbox')),
                  DropdownMenuItem(value: .ps4, child: Text('Playstation')),
                  DropdownMenuItem(value: .swi, child: Text('Nintendo')),
                  DropdownMenuItem(value: .mob, child: Text('iOS')),
                  DropdownMenuItem(value: .and, child: Text('Android')),
                ],
                onChanged: (value) => context.read<ProfileSetupCubit>().updatePlatform(value ?? .pc),
              ),
              Text(
                'Note: If you have Cross Platform Save enabled this is your accounts main platform. This will only affect how Navis pulls profile data.',
                style: noteStyle,
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Enter User Data'),
          content: Column(
            spacing: 24,
            children: [
              const Text(
                'Sign into warframe.com then copy and paste your user data in the field below to extract your account ID.',
              ),
              OverflowBar(
                overflowAlignment: .center,
                children: [
                  OutlinedButton(
                    onPressed: () => warframeLogin.launchLink(context),
                    child: const Text('Sign into warframe.com'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => warframeUserData.launchLink(context),
                    child: const Text('Get User Data'),
                  ),
                ],
              ),
              JsonTextField(
                onChanged: (value) => context.read<ProfileSetupCubit>().validateUserData(value),
              ),
              Text(
                'Note: Navis only needs the account ID but to prevent user errors its easier to select all',
                style: noteStyle,
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Complete Setup'),
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
}

class _StepsControls extends StatelessWidget {
  const _StepsControls(this.details);

  final ControlsDetails details;

  @override
  Widget build(BuildContext context) {
    final locale = MaterialLocalizations.of(context);
    final maxSteps = context.watch<ProfileSetupCubit>().maxSteps;
    final hasValidData = context.watch<ProfileSetupCubit>().state.isValidData;
    final enableContinue = details.currentStep != 2 || (hasValidData == true || hasValidData != null);
    final hasProfile = context.watch<ProfileCubit>().state is ProfileSuccessful;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          if (details.stepIndex > 0)
            OutlinedButton(onPressed: details.onStepCancel, child: Text(locale.backButtonTooltip)),
          if (details.stepIndex < maxSteps && !hasProfile)
            FilledButton(
              onPressed: enableContinue ? details.onStepContinue : null,
              child: Text(locale.continueButtonLabel),
            ),
          if (hasProfile)
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(locale.okButtonLabel),
            ),
        ],
      ),
    );
  }
}
