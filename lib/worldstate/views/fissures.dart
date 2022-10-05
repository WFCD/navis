import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
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
      child: const _FissuresView(),
    );
  }
}

class _FissuresView extends StatefulWidget {
  const _FissuresView();

  @override
  State<_FissuresView> createState() => _FissuresViewState();
}

class _FissuresViewState extends State<_FissuresView> {
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
  void initState() {
    super.initState();

    final ff = context.read<FissureFilterCubit>();
    _updateFocus(ff.state.type);

    // Need to make sure that fissures are updated from worldstate.
    // Otherwise fissures stored in the filter cubit will be out of sync.
    final state = context.read<SolsystemCubit>().state;
    final fissures =
        state is SolState ? state.worldstate.fissures : <VoidFissure>[];

    ff.filterFissures(ff.state.type, fissures);
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
              mobile: (context) => _MobileFissures(fissures: fissures),
              tablet: (context) => _TabletFissures(fissures: fissures),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileFissures extends StatelessWidget {
  const _MobileFissures({required this.fissures});

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    const cacheExntent = 300.0;
    final height = (MediaQuery.of(context).size.height / 100) * 15;

    return ListView.builder(
      cacheExtent: cacheExntent,
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

class _TabletFissures extends StatelessWidget {
  const _TabletFissures({required this.fissures});

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
