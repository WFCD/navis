import 'map_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../constants.dart';
import '../../ui/widgets/popup.dart';
import '../../ui/widgets/videoplayer.dart';
import '../../network/network.dart';

class Plains extends Mapbase {
  static BuildContext _context;

  Plains({@required context}) {
    _context = context;
  }

  static double _size = 50;

  List<String> filters = ['All', 'Caves', 'Fish', 'Lures', 'Odditys'];

  final home = Marker(
      height: _size,
      width: _size,
      point: LatLng(-42.68243539838622, 4.5703125),
      builder: (_) => Container(
          child: Image.network(
              'https://hub.warframestat.us/img/map_icons/home.png')));

  final List<Marker> _oldFish = Constants.oddity.map((o) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(o[1], o[2]),
        anchor: AnchorPos.center,
        anchorOverride: null,
        builder: (_) => InkWell(
            onTap: () async => Navigator.of(_context).push(Popup(
                context: _context,
                child: FishPlayer(
                    lore: o[3], url: await Network.fishVideos(o[4])))),
            child: Container(
                child: Image.network(
                    'https://hub.warframestat.us/img/map_icons/oddity.png'))));
  }).toList();

  final List<Marker> _lures = Constants.lure.map((a) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(a[1], a[2]),
        anchor: AnchorPos.center,
        anchorOverride: null,
        builder: (_) => Container(
              child: Image.network(
                  'https://hub.warframestat.us/img/map_icons/lure.png'),
            ));
  }).toList();

  final List<Marker> _fish = Constants.fish.map((f) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(f[1], f[2]),
        anchor: AnchorPos.center,
        anchorOverride: null,
        builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/fish.png')));
  }).toList();

  final List<Marker> _caves = Constants.cave.map((c) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(c[1], c[2]),
        anchor: AnchorPos.center,
        anchorOverride: null,
        builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/caves.png')));
  }).toList();

  @override
  filter(String filter) {
    List filters;
    switch (filter) {
      case 'Caves':
        filters = _caves..add(home);
        break;
      case 'Fish':
        filters = _fish..add(home);
        break;
      case 'Lures':
        filters = _lures..add(home);
        break;
      case 'Odditys':
        filters = _oldFish..add(home);
        break;
      case 'All':
        filters = [_lures, _fish, _caves, _oldFish].expand((x) => x).toList()
          ..add(home);
    }

    return filters;
  }
}
