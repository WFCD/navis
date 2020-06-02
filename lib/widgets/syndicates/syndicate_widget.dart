import 'package:flutter/material.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/screens/nightwaves.dart';
import 'package:navis/screens/syndicate_bounties.dart';
import 'package:navis/screens/synth_targets.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class SyndicateWidget extends StatelessWidget {
  const SyndicateWidget({
    this.name,
    this.caption,
    this.syndicate,
  }) : assert(
            name == null || syndicate == null,
            'If name is null then it will default\n'
            'to Syndicate.name instead');

  final String name, caption;

  /// [name] doesn't need to be applied if this is not null.
  final Syndicate syndicate;

  void onTap(BuildContext context) {
    final _syndicate = syndicateStringToEnum(name ?? syndicate.id);

    switch (_syndicate) {
      case SyndicateFactions.nightwave:
        Navigator.of(context).pushNamed(Nightwaves.route);
        break;
      case SyndicateFactions.simaris:
        Navigator.of(context).pushNamed(SynthTargetScreen.route);
        break;
      case SyndicateFactions.solarisSyndicate:
        continue SYNDICATEJOBS;
        break;

      SYNDICATEJOBS:
      case SyndicateFactions.cetusSyndicate:
        Navigator.of(context)
            .pushNamed(SyndicateJobs.route, arguments: syndicate);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final syndicateName = syndicateStringToEnum(name ?? syndicate.id);

    final titleStyle = textTheme.subtitle1
        .copyWith(color: Typography.whiteMountainView.subtitle1.color);

    final captionStyle = textTheme.caption
        .copyWith(color: Typography.whiteMountainView.caption.color);

    return Tiles(
      color: syndicateBackgroundColor(syndicateName),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 1,
          vertical: SizeConfig.widthMultiplier * 1.5,
        ),
        child: ListTile(
          leading: GetSyndicateIcon(syndicate: syndicateName),
          title: Text(name ?? syndicate.name, style: titleStyle),
          subtitle: Text(
            caption ?? NavisLocalizations.of(context).tapForMoreDetails,
            style: captionStyle,
          ),
          onTap: () => onTap(context),
        ),
      ),
    );
  }
}
