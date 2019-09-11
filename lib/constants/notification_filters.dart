import 'storage_keys.dart';

// Do I even need this anymore?
const rewards = {
  'vauban': 'Vauban Parts',
  'vandal': 'Vandadl Weapon Part',
  'wraith': 'Wraith Weapon Part',
  'skin': 'Skin Blueprint',
  'helmet': 'Helmet Blueprint',
  'nitain': 'Nitain Extract',
  'mutalist': 'Mutalist Alad V Nav Coordinate',
  'weapon': 'Weapon Blueprints',
  'fieldron': 'Fieldron Sample',
  'detonite': 'Detonite Ampule',
  'mutagen': 'Mutagen Samples',
  'aura': 'Aura Mods',
  'neuralSensors': 'Neural Sensors',
  'orokinCell': 'Orokin Cells',
  'alloyPlate': 'Alloy Plates',
  'circuits': 'Circuits',
  'controlModule': 'Control Modules',
  'ferrite': 'Ferrite',
  'gallium': 'Gallium',
  'morphics': 'Morphics',
  'nanoSpores': 'Nano Spores',
  'oxium': 'Oxium',
  'rubedo': 'Rubedo',
  'salvage': 'Salvage',
  'plastids': 'Plastids',
  'polymerBundle': 'Polymer Bundles',
  'argonCrystal': 'Argon Crystals',
  'cryotic': 'Cryotic',
  'tellurium': 'Tellurium',
  'neurodes': 'Neurodes',
  'nightmare': 'Nightmare Mods',
  'endo': 'Endo',
  'reactor': 'Orokin Reactors',
  'catalyst': 'Orokin Caralyst',
  'forma': 'Forma',
  'synthula': 'Synthula',
  'exilus': 'Exilus Adapater',
  'riven': 'Riven Mods',
  'kavatGene': 'Kavat Genes',
  'kubrowEgg': 'Kubrow Eggs',
  'traces': 'Void Traces',
  'other': 'Other Items',
  'credits': 'Credits'
};

const simple = [
  {
    'name': 'Rare Alerts',
    'description': 'Rare alert notifications, mainly gifts of the lotus',
    'key': NotificationKeys.alertsKey
  },
  // {
  //   'name': 'Baro Ki\'Teer Arrival',
  //   'description': 'For when Baro has arrived',
  //   'key': baroKey
  // },
  // {
  //   'name': 'Darvo\'s Daily Deals',
  //   'description': 'Darvo\'s new find of the day',
  //   'key': darvoKey
  // },
  {
    'name': 'Sorties',
    'description': 'Notifications for new sorties',
    'key': NotificationKeys.sortiesKey
  }
];

const filtered = {
  //'News': 'News notifications for Prime Access, Streams and Updates',
  'Cycles': 'Day/Night cycle notifications',
  //'Fissure Missions': 'Filter fissure notifications by prefered mission type',
  //'Acolytes': 'Notification for when an Acolyte is found',
};

const cycles = {
  NotificationKeys.earthDayKey: 'Earth Day Cycle',
  NotificationKeys.earthNightKey: 'Earth Night Cycle',
  NotificationKeys.dayKey: 'Cetus Day Cycle',
  NotificationKeys.nightKey: 'Cetus Night Cycle',
  NotificationKeys.warmKey: 'Orb Vallis Warm Cycle',
  NotificationKeys.coldKey: 'Orb Vallis Cold Cycle'
};

const newsType = {
  NotificationKeys.newsPrimeKey: 'Prime Access News',
  NotificationKeys.newsStreamKey: 'Stream Announcements',
  NotificationKeys.newsUpdateKey: 'Warframe update News'
};

const acolytes = {
  NotificationKeys.angstkey: 'Angst',
  NotificationKeys.maliceKey: 'Malice',
  NotificationKeys.maniaKey: 'Mania',
  NotificationKeys.miseryKey: 'Misery',
  NotificationKeys.tormentKey: 'Torment',
  NotificationKeys.violenceKey: 'Violence',
};

const missionTypes = {
  'key': 'missions_alert',
  'missions': [
    'Excavation',
    'Sabotage',
    'Mobile Defense',
    'Assassination',
    'Extermination',
    'Hive',
    'Defense',
    'Interception',
    'Rescue',
    'Spy',
    'Survival',
    'Capture',
    'Hijack',
    'Assault',
    'Defection',
    'Free Roam',
  ]
};
