import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile_setup/cubit/profile_setup_cubit.dart';

class JsonTextField extends StatelessWidget {
  const JsonTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileSetupCubit, ProfileSetupState, bool?>(
      selector: (state) => state.isValidData,
      builder: (context, state) {
        final color = switch (state) {
          true => Colors.green,
          false => context.colorScheme.error,
          null => null,
        };

        return TextFormField(
          maxLines: 3,
          validator: (input) {
            context.read<ProfileSetupCubit>().validateUserData(input);
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: color != null ? BorderSide(color: color) : const BorderSide()),
            labelText: context.l10n.inventoriaStepThreeTextLabel,
          ),
        );
      },
    );
  }
}
