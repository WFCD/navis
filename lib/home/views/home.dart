import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<Codex>(context);

    return BlocProvider(create: (_) => SearchBloc(repo), child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  RouteObserver<ModalRoute<void>>? _observer;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = SearchController();

    GoRouter.of(context).routerDelegate.addListener(_handleRouteChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _observer ??= RepositoryProvider.of<RouteObserver<ModalRoute<void>>>(context)
      ..subscribe(this, ModalRoute.of(context)!);
  }

  void _handleRouteChange() {
    if (!mounted) return;

    final currentRoute = ModalRoute.of(context);
    if (currentRoute?.isActive ?? false) {
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = [const WorldstateSection(), const MasteryInProgressSection()];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          clipBehavior: Clip.none,
          title: CodexSearchBar(focusNode: _focusNode, controller: _controller),
        ),
        SliverList.list(children: children),
      ],
    );
  }

  @override
  void dispose() {
    _observer?.unsubscribe(this);
    _observer = null;

    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
