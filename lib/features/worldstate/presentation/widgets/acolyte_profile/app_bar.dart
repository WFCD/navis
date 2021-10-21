import 'package:flutter/material.dart';

import '../../../presentation/widgets/common/background_image.dart';
import '../../../utils/skybox_loader.dart';

class AcolyteAppBar extends StatelessWidget {
  const AcolyteAppBar({
    Key? key,
    required this.acolyteName,
    required this.region,
  }) : super(key: key);

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
          radius: 45,
          backgroundImage: AssetImage(
            'assets/enemies/stalker/${acolyteName.toLowerCase()}.webp',
          ),
        ),
        centerTitle: true,
        background: BackgroundImage(imageUrl: getSkybox(region)),
      ),
    );
  }
}
