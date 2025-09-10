import 'dart:async';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = context.l10n;
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return Section(
      title: Text(i10n.warframeNewsTitle),
      content: BlocProvider(create: (_) => WorldstateBloc(wsRepo), child: const _NewsCarouselView()),
      onTap: () => const NewsPageRoute().push<void>(context),
    );
  }
}

class _NewsCarouselView extends StatefulWidget {
  const _NewsCarouselView();

  @override
  State<_NewsCarouselView> createState() => __NewsCarouselViewState();
}

class __NewsCarouselViewState extends State<_NewsCarouselView> {
  static const _maxItems = 5;
  static const _autoScrollDuration = Duration(seconds: 20);

  late final CarouselController _controller;

  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    _timer = Timer.periodic(_autoScrollDuration, (_) => _autoScroll());
  }

  void _autoScroll() {
    if (!mounted || !_controller.hasClients || !_controller.position.hasViewportDimension) return;

    final pageSize = MediaQuery.sizeOf(context).width * .9;
    var nextPage = (_currentPage + 1) % _maxItems;
    if (nextPage > _maxItems) nextPage = 0;

    final position = nextPage * pageSize;

    _controller.animateTo(position, duration: Durations.short4, curve: Curves.easeInOut);
    _currentPage = nextPage;
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (previous is! WorldstateSuccess && next is WorldstateSuccess) return true;
    if (previous is! WorldstateSuccess || next is! WorldstateSuccess) return false;

    return previous.seed.news.first.id != next.seed.news.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is! WorldstateSuccess) return const Center(child: WarframeSpinner());

        final news = state.seed.news.take(_maxItems).toList();
        final size = MediaQuery.sizeOf(context);
        final itemExtent = size.width * .9;

        return SizedBox(
          height: size.height * .25,
          child: GestureDetector(
            onTapDown: (_) => _timer?.cancel(),
            onHorizontalDragStart: (_) => _timer?.cancel(),
            onHorizontalDragEnd: (_) {
              final position = _controller.position.pixels;

              _currentPage = (position / itemExtent).round();
              _timer = Timer.periodic(_autoScrollDuration, (_) => _autoScroll());
            },
            child: CarouselView(
              controller: _controller,
              itemSnapping: true,
              itemExtent: itemExtent,
              shrinkExtent: itemExtent,
              onTap: (i) => news[i].link.launchLink(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              children: news
                  .map(
                    (n) => Card(
                      color: context.theme.colorScheme.secondaryContainer,
                      clipBehavior: Clip.antiAlias,
                      child: OrbiterNewsContent(news: n),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
