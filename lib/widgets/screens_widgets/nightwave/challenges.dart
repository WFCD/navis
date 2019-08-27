import 'package:flutter/material.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/icons.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class NightwaveChallenge extends StatelessWidget {
  const NightwaveChallenge({Key key, this.challenge}) : super(key: key);

  final Challenge challenge;

  Widget _standingBadge() {
    return StaticBox(
        color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Standing.standing, color: Colors.white, size: 15),
            Text('${challenge.reputation}',
                style: const TextStyle(color: Colors.white))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.caption.color;
    final title = Theme.of(context).textTheme.subhead;
    final desscription =
        Theme.of(context).textTheme.body1.copyWith(fontSize: 14, color: color);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(child: Text(challenge.title, style: title)),
              const SizedBox(height: 4.0),
              Container(child: Text(challenge.desc, style: desscription)),
              const SizedBox(height: 8.0),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (challenge?.isElite)
                      StaticBox.text(
                        color: Colors.red,
                        text: 'Elite',
                        size: 14,
                      ),
                    _standingBadge(),
                    CountdownBox(expiry: challenge.expiry)
                  ]),
            ]),
      ),
    );
  }
}
