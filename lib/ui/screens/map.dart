import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../network/network.dart';
import '../../resources/constants.dart';
import '../widgets/popup.dart';
import '../widgets/videoplayer.dart';

//TODO rework map and create one for Orb Vallis
class Maps extends StatefulWidget {
  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> with TickerProviderStateMixin {
  List<String> filter = ['All', 'Caves', 'Fish', 'Lures', 'Odditys'];
  List markers = <Marker>[
    Marker(
        height: 80.0,
        width: 80.0,
        point: LatLng(-42.68243539838622, 4.5703125),
        builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/home.png')))
  ];

  @override
  Widget build(BuildContext context) {
    List<Marker> oldFish = Constants.oddity.map((o) {
      return Marker(
          height: 80.0,
          width: 80.0,
          point: LatLng(o[1], o[2]),
          anchor: AnchorPos.center,
          anchorOverride: null,
          builder: (_) => InkWell(
              onTap: () async => Navigator.of(context).push(Popup(
                  context: context,
                  child: FishPlayer(
                      lore: o[3], url: await Network.fishVideos(o[4])))),
              child: Container(
                  child: Image.network(
                      'https://hub.warframestat.us/img/map_icons/oddity.png'))));
    }).toList();

    void filters(String filter) {
      List filters;
      switch (filter) {
        case 'Caves':
          filters = caves;
          break;
        case 'Fish':
          filters = fish;
          break;
        case 'Lures':
          filters = lures;
          break;
        case 'Odditys':
          filters = oldFish;
          break;
        case 'All':
          filters = [lures, fish, caves].expand((x) => x).toList();
      }
      setState(() {
        markers.removeRange(1, markers.length);
        markers.addAll(filters);
      });
    }

    return Scaffold(
        appBar: AppBar(title: Text("Cetus Map"), actions: <Widget>[
          PopupMenuButton<String>(
              elevation: 8.0,
              icon: Icon(Icons.sort),
              onSelected: filters,
              itemBuilder: (_) {
                return filter.map((f) {
                  return PopupMenuItem<String>(
                    child: ListTile(
                        title: Text(f), contentPadding: EdgeInsets.zero),
                    value: f,
                  );
                }).toList();
              })
        ]),
        body: FlutterMap(
          options:
              MapOptions(center: LatLng(0, 0), zoom: 3, minZoom: 0, maxZoom: 4),
          layers: [
            TileLayerOptions(
              maxZoom: 5,
              fromAssets: true,
              offlineMode: true,
              urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.png',
            ),
            MarkerLayerOptions(markers: markers)
          ],
        ));
  }
}

List<Marker> lures = Constants.lure.map((a) {
  return Marker(
      height: 80.0,
      width: 80.0,
      point: LatLng(a[1], a[2]),
      anchor: AnchorPos.center,
      anchorOverride: null,
      builder: (_) => Container(
            child: Image.network(
                'https://hub.warframestat.us/img/map_icons/lure.png'),
          ));
}).toList();

List<Marker> fish = Constants.fish.map((f) {
  return Marker(
      height: 80.0,
      width: 80.0,
      point: LatLng(f[1], f[2]),
      anchor: AnchorPos.center,
      anchorOverride: null,
      builder: (_) => Container(
          child: Image.network(
              'https://hub.warframestat.us/img/map_icons/fish.png')));
}).toList();

List<Marker> caves = Constants.cave.map((c) {
  return Marker(
      height: 80.0,
      width: 80.0,
      point: LatLng(c[1], c[2]),
      anchor: AnchorPos.center,
      anchorOverride: null,
      builder: (_) => Container(
          child: Image.network(
              'https://hub.warframestat.us/img/map_icons/caves.png')));
}).toList();
