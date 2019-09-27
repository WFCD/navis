import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/widgets/widgets.dart';

class NightWaveWidget extends StatelessWidget {
  const NightWaveWidget({Key key, @required this.season}) : super(key: key);

  final int season;

  @override
  Widget build(BuildContext context) {
    const size = Size(60, 60);

    final nightwaveIcon = SvgPicture.asset(
      'assets/sigils/NightwaveSyndicate.svg',
      height: size.height,
      width: size.width,
    );

    return Tiles(
      color: const Color(0xFF6c1822),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: ListTile(
          leading: nightwaveIcon,
          title: const Text('Nightwaves'),
          subtitle: Text('Season $season'),
          onTap: () => Navigator.of(context).pushNamed('/nightwave'),
        ),
      ),
    );
  }
}
