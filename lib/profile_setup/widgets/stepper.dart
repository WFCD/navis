import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile_setup/profile_setup.dart';
import 'package:navis_ui/navis_ui.dart';

class InventoriaSetup extends StatelessWidget {
  const InventoriaSetup({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: currentStep,
      onStepContinue: context.read<ProfileSetupCubit>().nextStep,
      onStepCancel: context.read<ProfileSetupCubit>().previousStep,
      onStepTapped: context.read<ProfileSetupCubit>().goToStep,
      steps: [
        Step(
          isActive: currentStep == 0,
          title: Text(context.l10n.inventoriaStepOneTitle),
          content: Text(context.l10n.inventoriaStepOne(faqPage, discordInvite)),
        ),
        Step(
          isActive: currentStep == 1,
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
          isActive: currentStep == 2,
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
              const JsonTextField(),
            ],
          ),
        ),
        Step(
          isActive: currentStep == 3,
          title: Text(context.l10n.inventoriaStepFourTitle),
          content: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return switch (state) {
                ProfileUpdating() => const WarframeSpinner(),
                ProfileFailure() => Center(child: Text(context.l10n.inventoriaProfileError)),
                ProfileSuccessful(profile: final p) => UserTitle(username: p.username, rank: p.masteryRank),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ],
    );
  }
}
