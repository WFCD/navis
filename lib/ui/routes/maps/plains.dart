import 'map_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:navis/utils/constants.dart';
import 'package:navis/ui/widgets/popup.dart';
import 'package:navis/ui/widgets/videoplayer.dart';
import 'package:navis/APIs/streamable.dart';

class Plains extends Mapbase {
  static BuildContext _context;

  Plains({@required context}) {
    _context = context;
  }

  static double _size = 25;

  List<String> filters = [
    'All',
    'Caves',
    'Fish',
    'Grineer',
    'Lures',
    'Odditys'
  ];

  final home = Marker(
      height: _size,
      width: _size,
      point: LatLng(-60.68243539838622, 4.5703125),
      builder: (_) => Container(
          child: Icon(Icons.home,
              color: Color.fromRGBO(183, 70, 36, 1.0), size: 30)));

  final List<Marker> _oldFish = Constants.oddity.map((o) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(o[1], o[2]),
        builder: (_) => InkWell(
            onTap: () async => Navigator.of(_context).push(Popup(
                child: VideoPlayer(
                    lore: o[3], url: await StreamableAPI.fishVideos(o[4])))),
            child: Container(
                child: Image.network(
                    'https://hub.warframestat.us/img/map_icons/oddity.png'))));
  }).toList();

  final List<Marker> _lures = Constants.lure.map((a) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(a[1], a[2]),
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
        builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/fish.png')));
  }).toList();

  final List<Marker> _caves = Constants.cave.map((c) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(c[1], c[2]),
        builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/caves.png')));
  }).toList();

  final List<Marker> _grineerBase = Constants.grineer.map((g) {
    return Marker(
        height: _size,
        width: _size,
        point: LatLng(g[1], g[2]),
        builder: (_) => SvgPicture.asset('assets/factions/Grineer.svg',
            height: 10, width: 10, color: Colors.red[700]));
  }).toList();

  @override
  List<Marker> filter(String filter) {
    List filters;
    switch (filter) {
      case 'Caves':
        filters = _caves;
        break;
      case 'Grineer':
        filters = _grineerBase;
        break;
      case 'Fish':
        filters = _fish;
        break;
      case 'Lures':
        filters = _lures;
        break;
      case 'Odditys':
        filters = _oldFish;
        break;
      case 'All':
        filters = [_lures, _fish, _caves, _oldFish, _grineerBase]
            .expand((x) => x)
            .toList();
    }

    return filters..add(home);
  }
}
