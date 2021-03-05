import 'package:intl/intl.dart';

import '../../constants/storage_keys.dart';
import '../../l10n/l10n.dart';

class LocalizedFilter {
  const LocalizedFilter(this.localizations);

  final NavisLocalizations localizations;

  List<Map<String, String>> get simpleFilters {
    return [
      {
        'name': localizations.rareAlertsNotificationTitle,
        'description': localizations.rareAlertsNotificationDescription,
        'key': NotificationKeys.alertsKey
      },
      {
        'name': localizations.baroNotificationTitle,
        'description': localizations.baroNotificationDescription,
        'key': NotificationKeys.baroKey
      },
      {
        'name': localizations.darvoNotificationTitle,
        'description': localizations.darvoNotificationDescription,
        'key': NotificationKeys.darvoKey
      },
      {
        'name': localizations.sortieNotificationTitle,
        'description': localizations.sortieNotificationDescription,
        'key': NotificationKeys.sortiesKey
      },
      {
        'name': localizations.sentientOutpostNotificationTitle,
        'description': localizations.sentientOutpostNotificationDescription,
        'key': NotificationKeys.sentientOutpost
      }
    ];
  }

  List<Map<String, String>> get filtered {
    return [
      {
        'title': localizations.warframeNewsNotificationTitle,
        'description': localizations.warframeNewsNotificationDescription,
        'type': 'news',
      },
      {
        'title': localizations.planetCyclesNotificationTitle,
        'description': localizations.planetCyclesNotificationDescription,
        'type': 'cycles'
      },
      {
        'title': localizations.resourcesNotificationTitle,
        'description': localizations.resourcesNotificationDescription,
        'type': 'resources'
      },
      {
        'title': localizations.fissuresNotificationTitle,
        'description': localizations.fissuresNotificationDescription,
        'type': 'fissures'
      },
      {
        'title': localizations.acolytesNotificationTitle,
        'description': localizations.acolytesNotificationDescription,
        'type': 'acolytes'
      }
    ];
  }

  Map<String, String> get planetCycles {
    return {
      NotificationKeys.dayKey: localizations.cetusDayOption,
      NotificationKeys.nightKey: localizations.cetusNightOption,
      NotificationKeys.earthDayKey: localizations.earthDayOption,
      NotificationKeys.earthNightKey: localizations.earthNightOption,
      NotificationKeys.warmKey: localizations.vallisWarmOption,
      NotificationKeys.coldKey: localizations.vallisColdOption,
      NotificationKeys.fassKey: localizations.cambionFassOption,
      NotificationKeys.vomeKey: localizations.cambionVomeOption,
    };
  }

  Map<String, String> get warframeNews {
    return {
      NotificationKeys.newsPrimeKey: localizations.primeAccessNewsOption,
      NotificationKeys.newsStreamKey: localizations.streamNewsOption,
      NotificationKeys.newsUpdateKey: localizations.updateNewsOption
    };
  }

  Map<String, String> get acolytes {
    return {
      NotificationKeys.angstkey: 'Angst',
      NotificationKeys.maliceKey: 'Malice',
      NotificationKeys.maniaKey: 'Mania',
      NotificationKeys.miseryKey: 'Misery',
      NotificationKeys.tormentKey: 'Torment',
      NotificationKeys.violenceKey: 'Violence',
    };
  }

  Map<String, String> get resources {
    return {
      NotificationKeys.sniptronVandalBP: 'Snipetron Vandal Blueprint',
      NotificationKeys.sniptronVandalBarrel: 'Snipetron Vandal Barrel',
      NotificationKeys.sniptronVandalReceiver: 'Snipetron Vandal Receiver',
      NotificationKeys.sniptronVandalStock: 'Snipetron Vandal Stock',
      NotificationKeys.sheevBlade: 'Sheev Blade',
      NotificationKeys.sheevHeatsink: 'Sheev Heatsink',
      NotificationKeys.sheevHilt: 'Sheev Hilt',
      NotificationKeys.deraVandalBP: 'Dera Vandal Blueprint',
      NotificationKeys.deraVandalBarrel: 'Dera Vandal Barrel',
      NotificationKeys.deraVandalReceiver: 'Dera Vandal Receiver',
      NotificationKeys.deraVandalStock: 'Dera Vandal Stock',
      NotificationKeys.wraithTwinVipersBP: 'Wraith Twin Vipers Blueprint',
      NotificationKeys.wraithTwinVipersBarrels: 'Wraith Twin Vipers Barrel',
      NotificationKeys.wraithTwinVipersReceivers: 'Wraith Twin Vipers Receiver',
      NotificationKeys.wraithTwinVipersLink: 'Wraith Twin Vipers Link',
      NotificationKeys.latronWraithBP: 'Latron Wraith Blueprint',
      NotificationKeys.latronWraithBarrel: 'Latron Wraith Barrel',
      NotificationKeys.latronWraithReceiver: 'Latron Wraith Receiver',
      NotificationKeys.latronWraithStock: 'Latron Wraith Stock',
      NotificationKeys.fieldron: 'Fieldron',
      NotificationKeys.detoniteInjector: 'Detonite Injector',
      NotificationKeys.aladNavCoordinate: 'Mutalist Alad V Nav Coordinate',
      NotificationKeys.mutagenMass: 'Mutagen Mass',
      NotificationKeys.orokinCatalyst: 'Orokin Catalyst',
      NotificationKeys.orokinReactor: 'Orokin Reactor',
      NotificationKeys.forma: 'Forma',
      NotificationKeys.exilusAdapter: 'Exilus Adapter',
      NotificationKeys.karakWraithBP: 'Karak Wraith Blueprint',
      NotificationKeys.karakWraithBarrel: 'Karak Wraith Barrel',
      NotificationKeys.karakWraithReceiver: 'Karak Wraith Receiver',
      NotificationKeys.karakWraithStock: 'Karak Wraith Stock',
      NotificationKeys.strunBP: 'Strun Wraith Blueprint',
      NotificationKeys.strunBarrel: 'Strun Wraith Barrel',
      NotificationKeys.strunReciever: 'Strun Wraith Reciever',
      NotificationKeys.strunStock: 'Strun Wraith Stock'
    };
  }

  static const tiers = <String>['Lith', 'Meso', 'Neo', 'Axi', 'Requiem'];

  Map<String, String> get fissures {
    const commonTypes = <String>[
      'disruption',
      'exterminate',
      'mobile_defense',
      'rescue',
      'spy',
      'survival',
    ];

    const missionTypes = <String>[
      'capture',
      'defense',
      'excavation',
      'interception',
      'hijack',
      'sabotage',
      ...commonTypes
    ];

    final filters = <String, String>{};

    for (final tier in tiers) {
      var objectives = missionTypes;

      if (tier == 'Requiem') {
        objectives = commonTypes;
      }

      for (final objective in objectives) {
        final cleaned = objective.replaceAll('_', ' ');

        filters['$tier.$objective'] =
            '$tier ${toBeginningOfSentenceCase(cleaned)}';
      }
    }

    return filters;
  }
}
