import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';

import '../nightwaveChallenges.dart';

class NightWaveStyle extends StatelessWidget {
  const NightWaveStyle({Key key, @required this.season}) : super(key: key);

  final int season;

  void _navigateToChallenges(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => const NightwaveChallenges()));

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      height: 100,
      provider: const AssetImage('assets/general/banner.webp'),
      child: InkWell(
        onTap: () => _navigateToChallenges(context),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(34, 34, 34, .2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Nightwave',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      )),
              Text(
                'Season $season',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
