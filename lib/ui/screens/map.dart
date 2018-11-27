import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:navis/resources/map/plains.dart';

enum Location { plains, vallis }

class Maps extends StatefulWidget {
  final Location location;

  Maps({this.location});

  MapState createState() => MapState();
}

class MapState extends State<Maps> {
  StreamController<List<Marker>> filter;

  Plains plains;

  @override
  void initState() {
    filter = StreamController<List<Marker>>();

    plains = Plains(context: context);
    super.initState();
  }

  @override
  void dispose() {
    filter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterButton = Theme(
        data: Theme.of(context)
            .copyWith(cardColor: Color.fromRGBO(34, 34, 34, 1)),
        child: PopupMenuButton<String>(
            onSelected: (f) => filter.add(plains.filter(f)),
            itemBuilder: (BuildContext context) => plains.filters.map((f) {
                  return PopupMenuItem<String>(
                    child: Text(f),
                    value: f,
                  );
                }).toList()));

    return Scaffold(
        appBar: AppBar(title: Text('Cetus'), actions: <Widget>[filterButton]),
        body: StreamBuilder<List<Marker>>(
            initialData: plains.filter('All'),
            stream: filter.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
              return FlutterMap(
                options: MapOptions(
                    center: LatLng(0, 0), zoom: 3, minZoom: 0, maxZoom: 4),
                layers: [
                  TileLayerOptions(
                    maxZoom: 5,
                    fromAssets: true,
                    offlineMode: true,
                    keepBuffer: 25,
                    backgroundColor: Color.fromRGBO(63, 92, 98, 1),
                    urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.png',
                  ),
                  MarkerLayerOptions(markers: snapshot.data)
                ],
              );
            }));
  }
}
