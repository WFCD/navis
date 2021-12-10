import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/codex/views/codex_search_view.dart';
import 'package:navis/synthtargets/synthtargets.dart';
import 'package:navis/worldstate/views/home.dart';
import 'package:navis/worldstate/views/orbiter_news.dart';

enum NavigationEvent { timers, warframeNews, codex, synthTargets }

class NavigationCubit extends Cubit<Widget> {
  NavigationCubit() : super(navigationMap[NavigationEvent.timers]!);

  static final Map<NavigationEvent, Widget> navigationMap = {
    NavigationEvent.timers: const FeedView(),
    NavigationEvent.warframeNews: const OrbiterNewsPage(),
    NavigationEvent.codex: const CodexSearchView(),
    NavigationEvent.synthTargets: const SynthTargetsView()
  };

  void changePage(NavigationEvent event) {
    emit(navigationMap[event]!);
  }
}
