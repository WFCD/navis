import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem/solsystem_bloc.dart';

class BlocProviders extends StatelessWidget {
  const BlocProviders({
    super.key,
    required this.solsystemCubit,
    required this.darvodealCubit,
    required this.child,
  });

  final SolsystemCubit solsystemCubit;

  final DarvodealCubit darvodealCubit;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: solsystemCubit),
        BlocProvider.value(value: darvodealCubit),
      ],
      child: child,
    );
  }
}
