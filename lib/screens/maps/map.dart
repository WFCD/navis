import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'plains.dart';

enum Location { plains, vallis }

class Maps extends StatefulWidget {
  const Maps({@required this.location});

  final Location location;

  @override
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

  Widget _mapBuilder(Location location) {
    switch (location) {
      case Location.plains:
        return _buildCetusMap(filter.stream, plains);
      default:
        return _buildVallisMap(<Marker>[]);
    }
  }

  Widget _tiles(Location location) {
    switch (location) {
      case Location.plains:
        return const Text('Plains of Eidolon');
      default:
        return const Text('Orb Vallis');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cetusFilter = <Widget>[
      Theme(
          data: Theme.of(context)
              .copyWith(cardColor: const Color.fromRGBO(34, 34, 34, 1)),
          child: PopupMenuButton<String>(
              icon: const Icon(Icons.sort),
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
            nePanBoundary: LatLng(65.0, 80.0),
            swPanBoundary: LatLng(-65.0, -80.0),
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 2,
              keepBuffer: 15,
              fromAssets: true,
              offlineMode: true,
              backgroundColor: const Color.fromRGBO(63, 92, 98, 1),
              urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.webp',
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
        keepBuffer: 15,
        offlineMode: true,
        fromAssets: true,
        backgroundColor: const Color.fromRGBO(221, 231, 240, 1),
        urlTemplate: 'assets/vallis/{z}/tile_{x}_{y}.webp',
      ),
      MarkerLayerOptions(markers: markers)
    ],
  );
}
