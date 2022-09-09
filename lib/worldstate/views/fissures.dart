import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/fissure_filter.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/fissure_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SolsystemCubit>().state;
    final fissures =
        state is SolState ? state.worldstate.fissures : <VoidFissure>[];

    return BlocProvider(
      create: (_) => FissureFilterCubit(fissures),
      child: const FissuresView(),
    );
  }
}

class FissuresView extends StatefulWidget {
  const FissuresView({super.key});

  @override
  State<FissuresView> createState() => _FissuresViewState();
}

class _FissuresViewState extends State<FissuresView> {
  final _allFocus = FocusNode();
  final _fissuresFocus = FocusNode();
  final _stormFocus = FocusNode();
  final _steelFocus = FocusNode();

  void _updateFocus(FissureFilter filter) {
    switch (filter) {
      case FissureFilter.all:
        _allFocus.requestFocus();
        break;
      case FissureFilter.fissures:
        _fissuresFocus.requestFocus();
        break;
      case FissureFilter.voidStorm:
        _stormFocus.requestFocus();
        break;
      case FissureFilter.steelPath:
        _steelFocus.requestFocus();
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFocus(context.watch<FissureFilterCubit>().state.type);
  }

  void _onPressed(BuildContext context, FissureFilter filter) {
    final state = context.read<SolsystemCubit>().state;
    final fissures =
        state is SolState ? state.worldstate.fissures : <VoidFissure>[];

    context.read<FissureFilterCubit>().filterFissures(filter, fissures);
    _updateFocus(filter);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final fissures = context.watch<FissureFilterCubit>().state.filter();

    final buttonStyle = ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.white;
        }

        return context.theme.isDark ? Colors.white : context.theme.primaryColor;
      }),
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return NavisColors.blue;
        }

        return Colors.transparent;
      }),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () => _onPressed(context, FissureFilter.all),
              focusNode: _allFocus,
              style: buttonStyle,
              child: Text(l10n.allFissuresButton),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(context, FissureFilter.fissures),
              focusNode: _fissuresFocus,
              style: buttonStyle,
              child: Text(l10n.fissuresTitle),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(context, FissureFilter.voidStorm),
              focusNode: _stormFocus,
              style: buttonStyle,
              child: Text(l10n.voidStormFissuresButton),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(context, FissureFilter.steelPath),
              focusNode: _steelFocus,
              style: buttonStyle,
              child: Text(l10n.steelPathTitle),
            ),
          ],
        ),
        Expanded(
          child: ViewLoading(
            isLoading: fissures.isEmpty,
            child: ScreenTypeLayout.builder(
              mobile: (context) => MobileFissures(fissures: fissures),
              tablet: (context) => TabletFissures(fissures: fissures),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileFissures extends StatelessWidget {
  const MobileFissures({super.key, required this.fissures});

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height / 100) * 15;

    return ListView.builder(
      cacheExtent: height * 5,
      itemExtent: height,
      itemCount: fissures.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(
          key: ValueKey(fissures[index].id),
          fissure: fissures[index],
        );
      },
    );
  }
}

class TabletFissures extends StatelessWidget {
  const TabletFissures({super.key, required this.fissures});

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 2,
      ),
      itemCount: fissures.length,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(fissure: fissures[index]);
      },
    );
  }
}
