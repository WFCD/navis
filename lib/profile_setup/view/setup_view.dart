import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile_setup/cubit/profile_setup_cubit.dart';
import 'package:navis/profile_setup/widgets/stepper.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  static Future<void> openBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => ProfileSetupCubit(),
        child: const SetupView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) => InventoriaSetup(currentStep: state.currentStep),
    );
  }
}
