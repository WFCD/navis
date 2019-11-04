import 'package:flutter/material.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateWidget extends StatelessWidget {
  const SyndicateWidget({
    this.name,
    this.caption = 'Tap to see bounties',
    this.syndicate,
  })  : assert(caption != null),
        assert(
            name == null || syndicate == null,
            'If name is null then it will default\n'
            'to Syndicate.name instead');

  final String name;
  final String caption;

  /// [name] doesn't need to be applied if this is not null.
  final Syndicate syndicate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final syndicateName = syndicateStringToEnum(syndicate.name);

    return Tiles(
      color: syndicateBackgroundColor(syndicateName),
      child: InkWell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetSyndicateIcon(syndicate: syndicate.name),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name ?? syndicate.name,
                      style: textTheme.subhead.copyWith(color: Colors.white),
                    ),
                    Text(
                      caption,
                      style: textTheme.body1
                          .copyWith(color: textTheme.caption.color),
                    )
                  ],
                ),
              )
            ])),
        onTap: () => Navigator.of(context)
            .pushNamed('/syndicate_jobs', arguments: syndicate),
      ),
    );
  }
}
