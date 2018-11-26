import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../resources/map/plains.dart';

enum Location { plains, vallis }

class Maps extends StatefulWidget {
  final Location location;

  Maps({this.location});

  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> with TickerProviderStateMixin {
  Plains _locaton;
  List<Marker> markers;

  @override
  void initState() {
    super.initState();
    _locaton = Plains(context: context);

    markers = _locaton.filter('All');
  }

  @override
  void dispose() {
    _locaton = null;
    markers = null;
    super.dispose();
  }

//used to rebuild filter list
  rebuild(String newfilter) {
    final newMarkers = _locaton.filter(newfilter);
    setState(() => markers = newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionButton = [
      PopupMenuButton<String>(
          icon: Icon(Icons.sort),
          onSelected: rebuild,
          padding: EdgeInsets.zero,
          itemBuilder: (_) {
            return _locaton.filters.map((f) {
              return PopupMenuItem<String>(
                child:
                    ListTile(title: Text(f), contentPadding: EdgeInsets.zero),
                value: f,
              );
            }).toList();
          })
    ];

    return Scaffold(
        appBar: AppBar(title: Text("Cetus Map"), actions: actionButton),
        body: FlutterMap(
          options:
              MapOptions(center: LatLng(0, 0), zoom: 3, minZoom: 0, maxZoom: 4),
          layers: [
            TileLayerOptions(
              maxZoom: 5,
              backgroundColor: Color.fromRGBO(63, 92, 98, 1),
              fromAssets: true,
              offlineMode: true,
              urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.png',
            ),
            MarkerLayerOptions(markers: markers)
          ],
        ));
  }
}
