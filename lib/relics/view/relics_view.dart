import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/item_search/item_search.dart';
import 'package:navis/items/items.dart';
import 'package:navis/relics/cubit/relics_cubit.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class RelicsPage extends StatelessWidget {
  const RelicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsRepository = context.read<ItemsRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RelicsCubit(itemsRepository)),
        BlocProvider(create: (_) => SearchBloc(itemsRepository)),
      ],
      child: const Scaffold(body: RelicsView()),
    );
  }
}

class RelicsView extends StatefulWidget {
  const RelicsView({super.key});

  @override
  State<RelicsView> createState() => _RelicsViewState();
}

class _RelicsViewState extends State<RelicsView> {
  late final List<ScrollController> _controllers;
  static const _tabs = <({IconData icon, FissureTier type})>[
    (icon: WarframeIcons.menuRelicLith, type: .lith),
    (icon: WarframeIcons.menuRelicMeso, type: .meso),
    (icon: WarframeIcons.menuRelicNeo, type: .neo),
    (icon: WarframeIcons.menuRelicAxi, type: .axi),
    (icon: WarframeIcons.menuRequiemRelic, type: .requiem),
  ];

  void _onTap(int index) {
    if (!mounted) return;
    context.read<RelicsCubit>().fetchRelics(_tabs[index].type);

    final controller = _controllers[index];
    if (!controller.hasClients) return;
    if (controller.position.pixels == 0) return;

    controller.animateTo(0, duration: Durations.short4, curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    _controllers = _tabs.map((i) => ScrollController(debugLabel: i.type.name)).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<RelicsCubit>().fetchRelics(_tabs.first.type);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, inner) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                clipBehavior: Clip.hardEdge,
                automaticallyImplyLeading: false,
                title: ItemsSearchBar(
                  enableItemFilter: false,
                  hintText: 'Find Relic',
                  onChange: (query) => context.read<SearchBloc>().add(RelicSearchTextChanged(query)),
                  onSubmit: (context, query) => context.read<SearchBloc>().add(RelicSearchTextChanged(query)),
                ),
                bottom: TabBar(
                  tabs: _tabs
                      .map((i) => Tab(icon: Icon(i.icon), text: toBeginningOfSentenceCase(i.type.name)))
                      .toList(),
                  onTap: _onTap,
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<RelicsCubit, RelicsState>(
          builder: (context, state) => switch (state) {
            RelicsSuccessful(:final relics) => _RelicsGrid(relics: relics),
            _ => const Center(child: WarframeSpinner()),
          },
        ),
      ),
    );
  }
}

class _RelicsGrid extends StatelessWidget {
  const _RelicsGrid({required this.relics});

  final List<RelicSet> relics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: relics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 120),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final displayName = relics[index].name;
        final relic = relics[index].intact;

        return OpenItemContainer(
          item: relics[index].intact,
          closedBuilder: (_, onTap) {
            return AppCard(
              contentPadding: EdgeInsets.zero,
              color: (relic.isVaulted ?? false) ? context.colorScheme.surfaceContainerLow : null,
              child: InkWell(
                onTap: onTap,
                child: Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  children: [
                    CachedNetworkImage(imageUrl: relic.imageName.warframeItemsCdn(), height: 75),
                    Text(displayName, style: context.textTheme.titleMedium),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
