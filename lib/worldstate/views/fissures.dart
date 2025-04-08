import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorldstateBloc>().state;
    final fissures = state is WorldstateSuccess ? state.seed.fissures : <Fissure>[];

    return BlocProvider(create: (_) => FissureFilterCubit(fissures), child: const _FissuresView());
  }
}

class _FissuresView extends StatefulWidget {
  const _FissuresView();

  @override
  State<_FissuresView> createState() => _FissuresViewState();
}

class _FissuresViewState extends State<_FissuresView> {
  final _fissuresFocus = FocusNode();
  final _stormFocus = FocusNode();
  final _steelFocus = FocusNode();

  void _updateFocus(FissureFilter filter) {
    switch (filter) {
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
    final state = context.read<WorldstateBloc>().state;
    final fissures = state is WorldstateSuccess ? state.seed.fissures : <Fissure>[];

    ff.filterFissures(ff.state.type, fissures);
  }

  @override
  Widget build(BuildContext context) {
    final fissures = context.watch<FissureFilterCubit>().state.fissures;

    return Column(
      children: [
        Gaps.gap8,
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
        return FissureWidget(key: ValueKey(fissures[index].id), fissure: fissures[index]);
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
    final state = context.read<WorldstateBloc>().state;
    final fissures = state is WorldstateSuccess ? state.seed.fissures : <Fissure>[];

    context.read<FissureFilterCubit>().filterFissures(filter, fissures);
  }

  Widget _toggleButton(NavisLocalizations l10n, FissureFilter filter) {
    final text = switch (filter) {
      FissureFilter.fissures => l10n.fissuresTitle,
      FissureFilter.voidStorm => l10n.voidStormFissuresButton,
      FissureFilter.steelPath => l10n.steelPathTitle,
    };

    final icon = switch (filter) {
      FissureFilter.fissures => WarframeIcons.fissuresRequiem,
      FissureFilter.voidStorm => WarframeIcons.archwing,
      FissureFilter.steelPath => WarframeIcons.spLogo,
    };

    return Tooltip(message: text, child: Row(children: [Icon(icon), Gaps.gap8, Text(text)]));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final screen = MediaQuery.sizeOf(context);

    return BlocListener<WorldstateBloc, WorldState>(
      listener: (context, state) {
        if (state is WorldstateSuccess) {
          BlocProvider.of<FissureFilterCubit>(context).updateFissues(state.seed.fissures);
        }
      },
      child: BlocBuilder<FissureFilterCubit, FissureFilterState>(
        builder: (_, state) {
          return ToggleButtons(
            constraints: BoxConstraints(minHeight: screen.height * .05, minWidth: screen.width * .32),
            borderRadius: BorderRadius.circular(8),
            isSelected: FissureFilter.values.map((i) => state.type == i).toList(),
            onPressed: (index) => onSelected(context, FissureFilter.values[index]),
            children: FissureFilter.values.map((i) => _toggleButton(l10n, i)).toList(),
          );
        },
      ),
    );
  }
}
