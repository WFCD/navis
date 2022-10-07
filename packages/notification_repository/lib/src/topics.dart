// ignore_for_file: public_member_api_docs

/// {@template topic}
/// An instance of the specfic topic.
/// {@endtemplate}
class Topic {
  /// {@macro topic}
  const Topic(this.name);

  /// Then name of the topic.
  final String name;

  @override
  String toString() => name;
}

/// This is an abstract class that holds all of our current constant topics that
/// we already use, minus fissures that are created dynamically in app.
///
/// The description for these are all in the name.
abstract class Topics {
  static const Topic earthDayKey = Topic('earth_day');
  static const Topic earthNightKey = Topic('earth_night');
  static const Topic dayKey = Topic('cetus_day');
  static const Topic nightKey = Topic('cetus_night');
  static const Topic warmKey = Topic('vallis_warm');
  static const Topic coldKey = Topic('vallis_cold');
  static const Topic vomeKey = Topic('cambion_vome');
  static const Topic fassKey = Topic('cambion_fass');

  static const Topic alertsKey = Topic('rare_alerts');
  static const Topic baroKey = Topic('baro');
  static const Topic darvoKey = Topic('darvo');
  static const Topic sortiesKey = Topic('sorties');
  static const Topic archonHuntKey = Topic('archon_hunt');
  static const Topic sentientOutpost = Topic('sentient_outpost');

  static const Topic newsPrimeKey = Topic('news_prime');
  static const Topic newsStreamKey = Topic('news_stream');
  static const Topic newsUpdateKey = Topic('news_update');

  static const Topic angstkey = Topic('angst_alert');
  static const Topic maliceKey = Topic('malice_alert');
  static const Topic maniaKey = Topic('mania_alert');
  static const Topic miseryKey = Topic('misery_alert');
  static const Topic tormentKey = Topic('torment_alert');
  static const Topic violenceKey = Topic('violence_alert');

  static const Topic sniptronVandalBP = Topic('sniptron_vandal_bp');
  static const Topic sniptronVandalBarrel = Topic('sniptron_vandal_barrel');
  static const Topic sniptronVandalReceiver = Topic('sniptron_vandal_receiver');
  static const Topic sniptronVandalStock = Topic('sniptron_vandal_stock');

  static const Topic sheevBlade = Topic('sheev_blade');
  static const Topic sheevHeatsink = Topic('sheev_heatsink');
  static const Topic sheevHilt = Topic('sheev_hilt');

  static const Topic deraVandalBarrel = Topic('dera_vandal_barrel');
  static const Topic deraVandalBP = Topic('dera_vandal_bp');
  static const Topic deraVandalReceiver = Topic('dera_vandal_receiver');
  static const Topic deraVandalStock = Topic('dera_vandal_stock');

  static const Topic wraithTwinVipersBP = Topic('wraith_twin_vipers_bp');
  static const Topic wraithTwinVipersBarrels =
      Topic('wraith_twin_vipers_barrels');
  static const Topic wraithTwinVipersReceivers =
      Topic('wraith_twin_vipers_receivers');
  static const Topic wraithTwinVipersLink = Topic('wraith_twin_vipers_link');

  static const Topic latronWraithReceiver = Topic('latron_wraith_receiver');
  static const Topic latronWraithBarrel = Topic('latron_wraith_barrel');
  static const Topic latronWraithStock = Topic('latron_wraith_stock');
  static const Topic latronWraithBP = Topic('latron_wraith_bp');

  static const Topic strunWraithBP = Topic('strung_wraith_bp');
  static const Topic strunWraithBarrel = Topic('strung_wraith_barrel');
  static const Topic strunWraithReceiver = Topic('strung_wraith_receiver');
  static const Topic strunWraithStock = Topic('strung_wraith_stock');

  static const Topic karakWraithBP = Topic('karak_wraith_bp');
  static const Topic karakWraithBarrel = Topic('karak_wraith_barrel');
  static const Topic karakWraithReceiver = Topic('karak_wraith_receiver');
  static const Topic karakWraithStock = Topic('karak_wraith_stock');

  static const Topic fieldron = Topic('fieldron');
  static const Topic detoniteInjector = Topic('detonite_injector');
  static const Topic aladNavCoordinate = Topic('mutalist_alad_nav_coordinate');
  static const Topic mutagenMass = Topic('mutagen_mass');
  static const Topic orokinCatalyst = Topic('orokin_catalyst');
  static const Topic orokinReactor = Topic('orokin_reactor');
  static const Topic forma = Topic('forma');
  static const Topic exilusAdapter = Topic('exilus_adapter');

  static const Topic strunBP = Topic('strun_bp');
  static const Topic strunBarrel = Topic('strun_barrel');
  static const Topic strunReciever = Topic('strun_reciever');
  static const Topic strunStock = Topic('strun_stock');

  static List<Topic> get topics {
    return [
      earthDayKey,
      earthNightKey,
      dayKey,
      nightKey,
      warmKey,
      coldKey,
      vomeKey,
      fassKey,
      alertsKey,
      baroKey,
      darvoKey,
      sortiesKey,
      archonHuntKey,
      sentientOutpost,
      newsPrimeKey,
      newsStreamKey,
      newsUpdateKey,
      angstkey,
      maliceKey,
      maniaKey,
      miseryKey,
      tormentKey,
      violenceKey,
      sniptronVandalBP,
      sniptronVandalBarrel,
      sniptronVandalReceiver,
      sniptronVandalStock,
      sheevBlade,
      sheevHeatsink,
      sheevHilt,
      deraVandalBarrel,
      deraVandalBP,
      deraVandalReceiver,
      deraVandalStock,
      wraithTwinVipersBP,
      wraithTwinVipersBarrels,
      wraithTwinVipersReceivers,
      wraithTwinVipersLink,
      latronWraithReceiver,
      latronWraithBarrel,
      latronWraithStock,
      latronWraithBP,
      strunWraithBP,
      strunWraithBarrel,
      strunWraithReceiver,
      strunWraithStock,
      karakWraithBP,
      karakWraithBarrel,
      karakWraithReceiver,
      karakWraithStock,
      fieldron,
      detoniteInjector,
      aladNavCoordinate,
      mutagenMass,
      orokinCatalyst,
      orokinReactor,
      forma,
      exilusAdapter,
      strunBP,
      strunBarrel,
      strunReciever,
      strunStock,
    ];
  }
}
