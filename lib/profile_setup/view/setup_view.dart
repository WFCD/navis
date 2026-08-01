import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile_setup/cubit/profile_setup_cubit.dart';
import 'package:navis/profile_setup/widgets/stepper.dart';
import 'package:settings_repository/settings_repository.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  static Future<void> openBottomSheet(BuildContext context) {
    final settings = context.read<SettingsRepository>();
    final profile = context.read<ProfileCubit>();

    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: profile),
            BlocProvider(create: (_) => ProfileSetupCubit(settings)),
          ],
          child: const SetupView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSetupCubit, ProfileSetupState>(
      listener: (context, state) {
        if (state.platform != null && state.isValidData == true) {
          context.read<ProfileCubit>().refreshProfile();
        }
      },
      child: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) => InventoriaSetup(currentStep: state.currentStep),
      ),
    );
  }
}
