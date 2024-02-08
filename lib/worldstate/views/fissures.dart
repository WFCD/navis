import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_client/warframestat_client.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorldstateCubit>().state;
    final fissures =
        state is WorldstateSuccess ? state.worldstate.fissures : <Fissure>[];

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
      case FissureFilter.fissures:
        _fissuresFocus.requestFocus();
      case FissureFilter.voidStorm:
        _stormFocus.requestFocus();
      case FissureFilter.steelPath:
        _steelFocus.requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();

    final ff = context.read<FissureFilterCubit>();
    _updateFocus(ff.state.type);

    // Need to make sure that fissures are updated from worldstate.
    // Otherwise fissures stored in the filter cubit will be out of sync.
    final state = context.read<WorldstateCubit>().state;
    final fissures =
        state is WorldstateSuccess ? state.worldstate.fissures : <Fissure>[];

    ff.filterFissures(ff.state.type, fissures);
  }

  @override
  Widget build(BuildContext context) {
    final fissures = context.watch<FissureFilterCubit>().state.filter();

    return Column(
      children: [
        const _FissureFilter(),
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

  final List<Fissure> fissures;

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

  final List<Fissure> fissures;

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

class _FissureFilter extends StatelessWidget {
  const _FissureFilter();

  void onSelected(BuildContext context, FissureFilter filter) {
    final state = context.read<WorldstateCubit>().state;
    final fissures =
        state is WorldstateSuccess ? state.worldstate.fissures : <Fissure>[];

    context.read<FissureFilterCubit>().filterFissures(filter, fissures);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<WorldstateCubit, SolsystemState>(
      listener: (context, state) {
        if (state is WorldstateSuccess) {
          BlocProvider.of<FissureFilterCubit>(context)
              .updateFissues(state.worldstate.fissures);
        }
      },
      child: BlocBuilder<FissureFilterCubit, FissureFilterState>(
        builder: (_, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: Text(l10n.allFissuresButton),
                tooltip: l10n.allFissuresButton,
                selected: state is Unfiltred,
                onSelected: (_) => onSelected(context, FissureFilter.all),
              ),
              ChoiceChip(
                label: Text(l10n.fissuresTitle),
                tooltip: l10n.fissuresTitle,
                selected: state is Fissures,
                onSelected: (_) => onSelected(context, FissureFilter.fissures),
              ),
              ChoiceChip(
                label: Text(l10n.voidStormFissuresButton),
                tooltip: l10n.voidStormFissuresButton,
                selected: state is VoidStorms,
                onSelected: (_) => onSelected(context, FissureFilter.voidStorm),
              ),
              ChoiceChip(
                label: Text(l10n.steelPathTitle),
                tooltip: l10n.steelPathTitle,
                selected: state is SteelPathFissures,
                onSelected: (_) => onSelected(context, FissureFilter.steelPath),
              ),
            ],
          );
        },
      ),
    );
  }
}
