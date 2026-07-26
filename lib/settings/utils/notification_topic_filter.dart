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
        value: Topics.alertsKey,
      ),
      SimpleTopics(
        title: l10n.operationAlertsNotificationTitle,
        description: l10n.operationAlertsNotificationDescription,
        value: Topics.operationAlertsKey,
      ),
      SimpleTopics(
        title: l10n.baroNotificationTitle,
        description: l10n.baroNotificationDescription,
        value: Topics.baroKey,
      ),
      SimpleTopics(
        title: l10n.darvoNotificationTitle,
        description: l10n.darvoNotificationDescription,
        value: Topics.darvoKey,
      ),
      SimpleTopics(
        title: l10n.sortieNotificationTitle,
        description: l10n.sortieNotificationDescription,
        value: Topics.sortiesKey,
      ),
      SimpleTopics(title: l10n.archonHuntTitle, description: l10n.archonHuntDescription, value: Topics.archonHuntKey),
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
      SimpleTopics(title: l10n.cetusDayOption, value: Topics.dayKey),
      SimpleTopics(title: l10n.cetusNightOption, value: Topics.nightKey),
      SimpleTopics(title: l10n.earthDayOption, value: Topics.earthDayKey),
      SimpleTopics(title: l10n.earthNightOption, value: Topics.earthNightKey),
      SimpleTopics(title: l10n.vallisWarmOption, value: Topics.warmKey),
      SimpleTopics(title: l10n.vallisColdOption, value: Topics.coldKey),
      SimpleTopics(title: l10n.cambionFassOption, value: Topics.fassKey),
      SimpleTopics(title: l10n.cambionVomeOption, value: Topics.vomeKey),
      SimpleTopics(title: l10n.duviriJoy, value: Topics.joyKey),
      SimpleTopics(title: l10n.duviriAnger, value: Topics.angerKey),
      SimpleTopics(title: l10n.duviriEnvy, value: Topics.envyKey),
      SimpleTopics(title: l10n.duviriSorrow, value: Topics.sorrowKey),
      SimpleTopics(title: l10n.duviriFear, value: Topics.fearKey),
    ];
  }

  List<SimpleTopics> get warframeNews {
    return [
      SimpleTopics(title: l10n.primeAccessNewsOption, value: Topics.newsPrimeKey),
      SimpleTopics(title: l10n.streamNewsOption, value: Topics.newsStreamKey),
      SimpleTopics(title: l10n.updateNewsOption, value: Topics.newsUpdateKey),
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
      SimpleTopics(title: 'Snipetron Vandal Blueprint', value: Topics.sniptronVandalBP),
      SimpleTopics(title: 'Snipetron Vandal Barrel', value: Topics.sniptronVandalBarrel),
      SimpleTopics(title: 'Snipetron Vandal Receiver', value: Topics.sniptronVandalReceiver),
      SimpleTopics(title: 'Snipetron Vandal Stock', value: Topics.sniptronVandalStock),
      SimpleTopics(title: 'Sheev Blueprint', value: Topics.sheevBlueprint),
      SimpleTopics(title: 'Sheev Blade', value: Topics.sheevBlade),
      SimpleTopics(title: 'Sheev Heatsink', value: Topics.sheevHeatsink),
      SimpleTopics(title: 'Sheev Hilt', value: Topics.sheevHilt),
      SimpleTopics(title: 'Dera Vandal Blueprint', value: Topics.deraVandalBP),
      SimpleTopics(title: 'Dera Vandal Barrel', value: Topics.deraVandalBarrel),
      SimpleTopics(title: 'Dera Vandal Receiver', value: Topics.deraVandalReceiver),
      SimpleTopics(title: 'Dera Vandal Stock', value: Topics.deraVandalStock),
      SimpleTopics(title: 'Wraith Twin Vipers Blueprint', value: Topics.wraithTwinVipersBP),
      SimpleTopics(title: 'Wraith Twin Vipers Barrel', value: Topics.wraithTwinVipersBarrels),
      SimpleTopics(title: 'Wraith Twin Vipers Receiver', value: Topics.wraithTwinVipersReceivers),
      SimpleTopics(title: 'Wraith Twin Vipers Link', value: Topics.wraithTwinVipersLink),
      SimpleTopics(title: 'Latron Wraith Blueprint', value: Topics.latronWraithBP),
      SimpleTopics(title: 'Latron Wraith Barrel', value: Topics.latronWraithBarrel),
      SimpleTopics(title: 'Latron Wraith Receiver', value: Topics.latronWraithReceiver),
      SimpleTopics(title: 'Latron Wraith Stock', value: Topics.latronWraithStock),
      SimpleTopics(title: 'Fieldron', value: Topics.fieldron),
      SimpleTopics(title: 'Detonite Injector', value: Topics.detoniteInjector),
      SimpleTopics(title: 'Mutalist Alad V Nav Coordinate', value: Topics.aladNavCoordinate),
      SimpleTopics(title: 'Mutagen Mass', value: Topics.mutagenMass),
      SimpleTopics(title: 'Orokin Catalyst', value: Topics.orokinCatalyst),
      SimpleTopics(title: 'Orokin Reactor', value: Topics.orokinReactor),
      SimpleTopics(title: 'Forma', value: Topics.forma),
      SimpleTopics(title: 'Exilus Adapter', value: Topics.exilusAdapter),
      SimpleTopics(title: 'Karak Wraith Blueprint', value: Topics.karakWraithBP),
      SimpleTopics(title: 'Karak Wraith Barrel', value: Topics.karakWraithBarrel),
      SimpleTopics(title: 'Karak Wraith Receiver', value: Topics.karakWraithReceiver),
      SimpleTopics(title: 'Karak Wraith Stock', value: Topics.karakWraithStock),
      SimpleTopics(title: 'Strun Wraith Blueprint', value: Topics.strunBP),
      SimpleTopics(title: 'Strun Wraith Barrel', value: Topics.strunBarrel),
      SimpleTopics(title: 'Strun Wraith Reciever', value: Topics.strunReciever),
      SimpleTopics(title: 'Strun Wraith Stock', value: Topics.strunStock),
    ];
  }

  Iterable<SimpleTopics> get fissures sync* {
    for (final topic in Topics.generateFissureTopics()) {
      final topicd = topic.name.split('.');
      final tier = topicd.first;
      final mission = topicd.last.replaceAll('_', ' ');

      yield SimpleTopics(title: '$tier ${toBeginningOfSentenceCase(mission)}', value: topic);
    }
  }
}

class SimpleTopics extends Equatable {
  const SimpleTopics({required this.title, this.description, required this.value});

  final String title;
  final String? description;
  final Topic value;

  @override
  List<Object?> get props => [title, description, value];
}

class MultiTopic extends Equatable {
  const MultiTopic({required this.title, required this.description, required this.filters});

  final String title;
  final String description;
  final List<SimpleTopics> filters;

  @override
  List<Object?> get props => [title, description, filters];
}
