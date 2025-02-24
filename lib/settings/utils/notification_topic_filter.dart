import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:notification_repository/notification_repository.dart';

class NotificationTopics {
  const NotificationTopics(this.l10n);

  final NavisLocalizations l10n;

  List<SimpleTopics> get simpleFilters {
    return [
      SimpleTopics(
        title: l10n.rareAlertsNotificationTitle,
        description: l10n.rareAlertsNotificationDescription,
        topic: Topics.alertsKey,
      ),
      SimpleTopics(
        title: l10n.operationAlertsNotificationTitle,
        description: l10n.operationAlertsNotificationDescription,
        topic: Topics.operationAlertsKey,
      ),
      SimpleTopics(
        title: l10n.baroNotificationTitle,
        description: l10n.baroNotificationDescription,
        topic: Topics.baroKey,
      ),
      SimpleTopics(
        title: l10n.darvoNotificationTitle,
        description: l10n.darvoNotificationDescription,
        topic: Topics.darvoKey,
      ),
      SimpleTopics(
        title: l10n.sortieNotificationTitle,
        description: l10n.sortieNotificationDescription,
        topic: Topics.sortiesKey,
      ),
      SimpleTopics(title: l10n.archonHuntTitle, description: l10n.archonHuntDescription, topic: Topics.archonHuntKey),
      // SimpleTopics(
      //   title: l10n.sentientOutpostNotificationTitle,
      //   description: l10n.sentientOutpostNotificationDescription,
      //   topic: Topics.sentientOutpost,
      // ),
    ];
  }

  List<MultiTopic> get filtered {
    return [
      MultiTopic(
        title: l10n.warframeNewsNotificationTitle,
        description: l10n.warframeNewsNotificationDescription,
        filters: [...warframeNews]..sort((a, b) => a.title.compareTo(b.title)),
      ),
      MultiTopic(
        title: l10n.planetCyclesNotificationTitle,
        description: l10n.planetCyclesNotificationDescription,
        filters: [...planetCycles]..sort((a, b) => a.title.compareTo(b.title)),
      ),
      MultiTopic(
        title: l10n.resourcesNotificationTitle,
        description: l10n.resourcesNotificationDescription,
        filters: [...resources]..sort((a, b) => a.title.compareTo(b.title)),
      ),
      MultiTopic(
        title: l10n.fissuresNotificationTitle,
        description: l10n.fissuresNotificationDescription,
        filters: fissures.toList(),
      ),
      // MultiTopic(
      //   title: l10n.acolytesNotificationTitle,
      //   description: l10n.acolytesNotificationDescription,
      //   filters: acolytes,
      // ),
    ];
  }

  List<SimpleTopics> get planetCycles {
    return [
      SimpleTopics(title: l10n.cetusDayOption, topic: Topics.dayKey),
      SimpleTopics(title: l10n.cetusNightOption, topic: Topics.nightKey),
      SimpleTopics(title: l10n.earthDayOption, topic: Topics.earthDayKey),
      SimpleTopics(title: l10n.earthNightOption, topic: Topics.earthNightKey),
      SimpleTopics(title: l10n.vallisWarmOption, topic: Topics.warmKey),
      SimpleTopics(title: l10n.vallisColdOption, topic: Topics.coldKey),
      SimpleTopics(title: l10n.cambionFassOption, topic: Topics.fassKey),
      SimpleTopics(title: l10n.cambionVomeOption, topic: Topics.vomeKey),
      SimpleTopics(title: l10n.duviriJoy, topic: Topics.joyKey),
      SimpleTopics(title: l10n.duviriAnger, topic: Topics.angerKey),
      SimpleTopics(title: l10n.duviriEnvy, topic: Topics.envyKey),
      SimpleTopics(title: l10n.duviriSorrow, topic: Topics.sorrowKey),
      SimpleTopics(title: l10n.duviriFear, topic: Topics.fearKey),
    ];
  }

  List<SimpleTopics> get warframeNews {
    return [
      SimpleTopics(title: l10n.primeAccessNewsOption, topic: Topics.newsPrimeKey),
      SimpleTopics(title: l10n.streamNewsOption, topic: Topics.newsStreamKey),
      SimpleTopics(title: l10n.updateNewsOption, topic: Topics.newsUpdateKey),
    ];
  }

  // List<SimpleTopics> get acolytes {
  //   return const [
  //     SimpleTopics(title: 'Angst', topic: Topics.angstkey),
  //     SimpleTopics(title: 'Malice', topic: Topics.maliceKey),
  //     SimpleTopics(title: 'Misery', topic: Topics.miseryKey),
  //     SimpleTopics(title: 'Torment', topic: Topics.tormentKey),
  //     SimpleTopics(title: 'Violence', topic: Topics.violenceKey),
  //   ];
  // }

  // It's a really long list.
  // ignore: long-method
  List<SimpleTopics> get resources {
    return const [
      SimpleTopics(title: 'Snipetron Vandal Blueprint', topic: Topics.sniptronVandalBP),
      SimpleTopics(title: 'Snipetron Vandal Barrel', topic: Topics.sniptronVandalBarrel),
      SimpleTopics(title: 'Snipetron Vandal Receiver', topic: Topics.sniptronVandalReceiver),
      SimpleTopics(title: 'Snipetron Vandal Stock', topic: Topics.sniptronVandalStock),
      SimpleTopics(title: 'Sheev Blade', topic: Topics.sheevBlade),
      SimpleTopics(title: 'Sheev Heatsink', topic: Topics.sheevHeatsink),
      SimpleTopics(title: 'Sheev Hilt', topic: Topics.sheevHilt),
      SimpleTopics(title: 'Dera Vandal Blueprint', topic: Topics.deraVandalBP),
      SimpleTopics(title: 'Dera Vandal Barrel', topic: Topics.deraVandalBarrel),
      SimpleTopics(title: 'Dera Vandal Receiver', topic: Topics.deraVandalReceiver),
      SimpleTopics(title: 'Dera Vandal Stock', topic: Topics.deraVandalStock),
      SimpleTopics(title: 'Wraith Twin Vipers Blueprint', topic: Topics.wraithTwinVipersBP),
      SimpleTopics(title: 'Wraith Twin Vipers Barrel', topic: Topics.wraithTwinVipersBarrels),
      SimpleTopics(title: 'Wraith Twin Vipers Receiver', topic: Topics.wraithTwinVipersReceivers),
      SimpleTopics(title: 'Wraith Twin Vipers Link', topic: Topics.wraithTwinVipersLink),
      SimpleTopics(title: 'Latron Wraith Blueprint', topic: Topics.latronWraithBP),
      SimpleTopics(title: 'Latron Wraith Barrel', topic: Topics.latronWraithBarrel),
      SimpleTopics(title: 'Latron Wraith Receiver', topic: Topics.latronWraithReceiver),
      SimpleTopics(title: 'Latron Wraith Stock', topic: Topics.latronWraithStock),
      SimpleTopics(title: 'Fieldron', topic: Topics.fieldron),
      SimpleTopics(title: 'Detonite Injector', topic: Topics.detoniteInjector),
      SimpleTopics(title: 'Mutalist Alad V Nav Coordinate', topic: Topics.aladNavCoordinate),
      SimpleTopics(title: 'Mutagen Mass', topic: Topics.mutagenMass),
      SimpleTopics(title: 'Orokin Catalyst', topic: Topics.orokinCatalyst),
      SimpleTopics(title: 'Orokin Reactor', topic: Topics.orokinReactor),
      SimpleTopics(title: 'Forma', topic: Topics.forma),
      SimpleTopics(title: 'Exilus Adapter', topic: Topics.exilusAdapter),
      SimpleTopics(title: 'Karak Wraith Blueprint', topic: Topics.karakWraithBP),
      SimpleTopics(title: 'Karak Wraith Barrel', topic: Topics.karakWraithBarrel),
      SimpleTopics(title: 'Karak Wraith Receiver', topic: Topics.karakWraithReceiver),
      SimpleTopics(title: 'Karak Wraith Stock', topic: Topics.karakWraithStock),
      SimpleTopics(title: 'Strun Wraith Blueprint', topic: Topics.strunBP),
      SimpleTopics(title: 'Strun Wraith Barrel', topic: Topics.strunBarrel),
      SimpleTopics(title: 'Strun Wraith Reciever', topic: Topics.strunReciever),
      SimpleTopics(title: 'Strun Wraith Stock', topic: Topics.strunStock),
    ];
  }

  Iterable<SimpleTopics> get fissures sync* {
    for (final topic in Topics.generateFissureTopics()) {
      final topicd = topic.name.split('.');
      final tier = topicd.first;
      final mission = topicd.last.replaceAll('_', ' ');

      yield SimpleTopics(title: '$tier ${toBeginningOfSentenceCase(mission)}', topic: topic);
    }
  }
}

class SimpleTopics extends Equatable {
  const SimpleTopics({required this.title, this.description, required this.topic});

  final String title;
  final String? description;
  final Topic topic;

  @override
  List<Object?> get props => [title, description, topic];
}

class MultiTopic extends Equatable {
  const MultiTopic({required this.title, required this.description, required this.filters});

  final String title;
  final String description;
  final List<SimpleTopics> filters;

  @override
  List<Object?> get props => [title, description, filters];
}
