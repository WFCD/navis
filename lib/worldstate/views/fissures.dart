import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/fissure_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class FissuresPage extends TraceableStatefulWidget {
  const FissuresPage({super.key});

  @override
  State<FissuresPage> createState() => _FissuresPageState();
}

enum FissureFilter { all, fissures, voidStorm, steelPath }

class _FissuresPageState extends State<FissuresPage> {
  late SolsystemState state;
  late List<VoidFissure> _fissures;
  FissureFilter _filter = FissureFilter.all;

  final _allFocus = FocusNode();
  final _fissuresFocus = FocusNode();
  final _stormFocus = FocusNode();
  final _steelFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    state = context.read<SolsystemCubit>().state;
    _fissures = state is SolState
        ? (state as SolState).worldstate.fissures
        : <VoidFissure>[];
  }

  void _onPressed(FissureFilter filter) {
    if (!mounted) return;

    final original = state is SolState
        ? (state as SolState).worldstate.fissures
        : <VoidFissure>[];

    List<VoidFissure> f;
    switch (filter) {
      case FissureFilter.all:
        f = List<VoidFissure>.from(original);
        break;
      case FissureFilter.fissures:
        f = List<VoidFissure>.from(original)
            .where((f) => !f.isHard && !f.isStorm)
            .toList();
        break;
      case FissureFilter.voidStorm:
        f = List<VoidFissure>.from(original).where((f) => f.isStorm).toList();
        break;
      case FissureFilter.steelPath:
        f = List<VoidFissure>.from(original).where((f) => f.isHard).toList();
        break;
    }

    setState(() {
      _fissures = f;
      _filter = filter;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final buttonStyle = ButtonStyle(
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
              onPressed: () => _onPressed(FissureFilter.all),
              focusNode: _allFocus,
              style: buttonStyle,
              child: Text(l10n.allFissuresButton),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(FissureFilter.fissures),
              focusNode: _fissuresFocus,
              style: buttonStyle,
              child: Text(l10n.fissuresTitle),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(FissureFilter.voidStorm),
              focusNode: _stormFocus,
              style: buttonStyle,
              child: Text(l10n.voidStormFissuresButton),
            ),
            OutlinedButton(
              onPressed: () => _onPressed(FissureFilter.steelPath),
              focusNode: _steelFocus,
              style: buttonStyle,
              child: Text(l10n.steelPathTitle),
            ),
          ],
        ),
        Expanded(
          child: ViewLoading(
            isLoading: state is! SolState,
            child: state is! SolState
                ? nil
                : ScreenTypeLayout.builder(
                    mobile: (context) => MobileFissures(fissures: _fissures),
                    tablet: (context) => TabletFissures(fissures: _fissures),
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
