// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static m0(lastSeenTime) => "hace ${lastSeenTime} minutos";

  static m1(agentType, rank) => "${agentType} | Nivel: ${rank}";

  static m2(type, faction, min, max) => "${type} (${faction}) | Nivel: ${min} - ${max}";

  static m3(date) => "Termina en ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "acolyteCurrentLocation" : MessageLookupByLibrary.simpleMessage("Ubicación actual"),
    "acolyteElapsedTime" : m0,
    "acolyteFound" : MessageLookupByLibrary.simpleMessage("Encontrado"),
    "acolyteHealth" : MessageLookupByLibrary.simpleMessage("Salud"),
    "acolyteLastSeen" : MessageLookupByLibrary.simpleMessage("Visto por última vez"),
    "acolytePassLocation" : MessageLookupByLibrary.simpleMessage("Última ubicación conocida"),
    "acolyteRank" : MessageLookupByLibrary.simpleMessage("Nivel del acólito"),
    "activeAcolyte" : m1,
    "alertInfo" : m2,
    "baroArrivesOn" : MessageLookupByLibrary.simpleMessage("Llega a las"),
    "baroArriving" : MessageLookupByLibrary.simpleMessage("Baro Ki\'Teer llega en"),
    "baroInventory" : MessageLookupByLibrary.simpleMessage("Inventario de Baro Ki\'teer"),
    "baroLeavesOn" : MessageLookupByLibrary.simpleMessage("Se va a las"),
    "baroLeaving" : MessageLookupByLibrary.simpleMessage("Baro Ki\'Teer se va en"),
    "baroLocation" : MessageLookupByLibrary.simpleMessage("Ubicación"),
    "baroTitle" : MessageLookupByLibrary.simpleMessage("Comerciante del vacío"),
    "bountyTitle" : MessageLookupByLibrary.simpleMessage("Contratos"),
    "cetusCycleTitle" : MessageLookupByLibrary.simpleMessage("Ciclo de Cetus"),
    "countdownTooltip" : m3,
    "earthCycleTitle" : MessageLookupByLibrary.simpleMessage("Ciclo de la Tierra"),
    "errorDescription" : MessageLookupByLibrary.simpleMessage("Hubo un error inesperado en el sistema central.\nReportando el error al administrador del sistema..."),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("Ocurrió un error en la aplicación"),
    "eventDescription" : MessageLookupByLibrary.simpleMessage("Descripción"),
    "eventRewards" : MessageLookupByLibrary.simpleMessage("Recompensas"),
    "eventStatus" : MessageLookupByLibrary.simpleMessage("Estado del evento"),
    "eventStatusEta" : MessageLookupByLibrary.simpleMessage("Tiempo restante (estimado)"),
    "eventStatusNode" : MessageLookupByLibrary.simpleMessage("Nodo"),
    "eventStatusProgress" : MessageLookupByLibrary.simpleMessage("Progreso"),
    "fissuresTitle" : MessageLookupByLibrary.simpleMessage("Fisuras"),
    "formorianTitle" : MessageLookupByLibrary.simpleMessage("Fomorian"),
    "invasionsTitle" : MessageLookupByLibrary.simpleMessage("Invasiones"),
    "kuvaBanner" : MessageLookupByLibrary.simpleMessage("El kuva se actualizará en"),
    "locating" : MessageLookupByLibrary.simpleMessage("Buscando..."),
    "razorbackTitle" : MessageLookupByLibrary.simpleMessage("Razorback"),
    "seeDetails" : MessageLookupByLibrary.simpleMessage("Ver detalles"),
    "syndicatesTitle" : MessageLookupByLibrary.simpleMessage("Sindicatos"),
    "tapForMoreDetails" : MessageLookupByLibrary.simpleMessage("Pulsa para más detalles"),
    "timersTitle" : MessageLookupByLibrary.simpleMessage("Contadores"),
    "vallisCycleTitle" : MessageLookupByLibrary.simpleMessage("Ciclo de Vallis")
  };
}
