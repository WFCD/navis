import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> appScaffold = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> settings = GlobalKey<ScaffoldState>();

PageStorageKey feed = const PageStorageKey<String>('feed');

final newsBucket = PageStorageBucket();
const newsKey = PageStorageKey('News');

final eventsBucket = PageStorageBucket();
const eventsKey = PageStorageKey('Events');

final dealsBucket = PageStorageBucket();
const dealskey = PageStorageKey('deals');
