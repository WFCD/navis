import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:navis/explore/explore.dart';
import 'package:navis/profile/views/profile_view.dart';
import 'package:navis/worldstate/views/home.dart';
import 'package:navis/worldstate/views/orbiter_news.dart';

enum NavigationEvent { timers, warframeNews, explore, profile }

class NavigationCubit extends Cubit<Widget> {
  NavigationCubit() : super(navigationMap[NavigationEvent.timers]!);

  static final Map<NavigationEvent, Widget> navigationMap = {
    NavigationEvent.timers: const FeedView(),
    NavigationEvent.warframeNews: const OrbiterNewsPage(),
    NavigationEvent.explore: const ExplorePage(),
    NavigationEvent.profile: const ProfilePage(),
  };

  void changePage(NavigationEvent event) {
    emit(navigationMap[event]!);
  }
}
