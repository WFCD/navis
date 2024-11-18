import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/explore/explore.dart';
import 'package:navis/worldstate/views/activities.dart';
import 'package:navis/worldstate/views/orbiter_news.dart';

enum NavigationEvent { timers, warframeNews, explore }

class NavigationCubit extends Cubit<Widget> {
  NavigationCubit() : super(navigationMap[NavigationEvent.timers]!);

  static final Map<NavigationEvent, Widget> navigationMap = {
    NavigationEvent.timers: const ActivitiesView(),
    NavigationEvent.warframeNews: const OrbiterNewsPage(),
    NavigationEvent.explore: const ExplorePage(),
  };

  void changePage(NavigationEvent event) {
    emit(navigationMap[event]!);
  }
}
