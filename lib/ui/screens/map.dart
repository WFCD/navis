import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:navis/resources/map/plains.dart';

enum Location { plains, vallis }

class Maps extends StatefulWidget {
  final Location location;

  Maps({@required this.location});

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

  _mapBuilder(Location location) {
    switch (location) {
      case Location.plains:
        return _buildCetusMap(filter.stream, plains);
      case Location.vallis:
        return _buildVallisMap(<Marker>[]);
    }
  }

  _tiles(Location location) {
    switch (location) {
      case Location.plains:
        return Text('Plains of Eidolon');
      case Location.vallis:
        return Text('Orb Vallis');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cetusFilter = <Widget>[
      Theme(
          data: Theme.of(context)
              .copyWith(cardColor: Color.fromRGBO(34, 34, 34, 1)),
          child: PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              onSelected: (f) => filter.add(plains.filter(f)),
              itemBuilder: (BuildContext context) => plains.filters.map((f) {
                    return PopupMenuItem<String>(
                      child: Text(f),
                      value: f,
                    );
                  }).toList()))
    ];

    return Scaffold(
        appBar: AppBar(
            title: _tiles(widget.location),
            actions:
                widget.location == Location.plains ? cetusFilter : <Widget>[]),
        body: _mapBuilder(widget.location));
  }
}

Widget _buildCetusMap(Stream filter, Plains plains) {
  return StreamBuilder<List<Marker>>(
      initialData: plains.filter('All'),
      stream: filter,
      builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
        return FlutterMap(
          options: MapOptions(
            center: LatLng(0, 0),
            zoom: 3,
            minZoom: 1,
            maxZoom: 2,
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 2,
              fromAssets: true,
              offlineMode: true,
              keepBuffer: 20,
              backgroundColor: Color.fromRGBO(63, 92, 98, 1),
              urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.png',
            ),
            MarkerLayerOptions(markers: snapshot.data)
          ],
        );
      });
}

Widget _buildVallisMap(List<Marker> markers) {
  return FlutterMap(
    options: MapOptions(
      center: LatLng(0, 0),
      zoom: 3,
      minZoom: 1,
      maxZoom: 4,
    ),
    layers: [
      TileLayerOptions(
        maxZoom: 4,
        fromAssets: true,
        offlineMode: true,
        keepBuffer: 25,
        backgroundColor: Color.fromRGBO(221, 231, 240, 1),
        urlTemplate: 'assets/vallis/{z}/tile_{x}_{y}.png',
      ),
      MarkerLayerOptions(markers: markers)
    ],
  );
}
