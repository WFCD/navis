import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'plains_components/plain_markers.dart';

class CetusMap extends StatelessWidget {
  const CetusMap({this.filter, this.plains});

  final Stream filter;
  final Plains plains;

  @override
  Widget build(BuildContext context) {
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
              nePanBoundary: LatLng(60.0, 60.0),
              //swPanBoundary: LatLng(-65.0, -80.0),
            ),
            layers: [
              TileLayerOptions(
                maxZoom: 2,
                keepBuffer: 15,
                offlineMode: true,
                backgroundColor: const Color.fromRGBO(63, 92, 98, 1),
                urlTemplate: 'assets/plains/{z}/tile_{x}_{y}.webp',
              ),
              MarkerLayerOptions(markers: snapshot.data)
            ],
          );
        });
  }
}
