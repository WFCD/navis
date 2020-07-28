import 'package:flutter/material.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/background_image.dart';
import 'package:navis/injection_container.dart';

import '../../../data/datasources/skybox_parser.dart';

class AcolyteAppBar extends StatelessWidget {
  const AcolyteAppBar(
      {Key key, @required this.acolyteName, @required this.region})
      : assert(acolyteName != null),
        assert(region != null),
        super(key: key);

  final String acolyteName;
  final String region;

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
        background: BackgroundImage(
          imageUrl: sl<SkyboxService>().getSkybox(region),
        ),
      ),
    );
  }
}
