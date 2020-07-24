import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/resources/resources.dart';

import '../../../data/datasources/skybox_parser.dart';

class AcolyteAppBar extends StatelessWidget {
  const AcolyteAppBar(
      {Key key, @required this.acolyteName, @required this.region})
      : assert(acolyteName != null),
        assert(region != null),
        super(key: key);

  final String acolyteName;
  final String region;

  static const _derelict = AssetImage(Resources.derelictSkybox);

  Widget _imageBuilder(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(acolyteName),
      backgroundColor: Colors.red[900],
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 45.0,
          backgroundImage: AssetImage(
            'assets/enemies/stalker/${acolyteName.toLowerCase()}.webp',
          ),
        ),
        centerTitle: true,
        background: CachedNetworkImage(
          imageUrl: sl<SkyboxService>().getSkybox(region),
          imageBuilder: (context, imageProvider) =>
              _imageBuilder(imageProvider),
          placeholder: (context, url) => _imageBuilder(_derelict),
          errorWidget: (context, url, dynamic error) =>
              _imageBuilder(_derelict),
        ),
      ),
    );
  }
}
