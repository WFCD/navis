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

  static m0(lastSeenTime) => "${lastSeenTime} minutes ago";

  static m1(agentType, rank) => "${agentType} | level: ${rank}";

  static m2(type, faction, min, max) => "${type} (${faction}) | Level: ${min} - ${max}";

  static m3(date) => "Ends on ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "acolyteCurrentLocation" : MessageLookupByLibrary.simpleMessage("Current location"),
    "acolyteElapsedTime" : m0,
    "acolyteFound" : MessageLookupByLibrary.simpleMessage("Found"),
    "acolyteHealth" : MessageLookupByLibrary.simpleMessage("Health"),
    "acolyteLastSeen" : MessageLookupByLibrary.simpleMessage("Last seen"),
    "acolytePassLocation" : MessageLookupByLibrary.simpleMessage("Last seen location"),
    "acolyteRank" : MessageLookupByLibrary.simpleMessage("Acolyte Level"),
    "activeAcolyte" : m1,
    "alertInfo" : m2,
    "baroArrivesOn" : MessageLookupByLibrary.simpleMessage("Arrives on"),
    "baroArriving" : MessageLookupByLibrary.simpleMessage("Baro Ki\'Teer arrives in"),
    "baroInventory" : MessageLookupByLibrary.simpleMessage("Baro Ki\'Teeer Inventory"),
    "baroLeavesOn" : MessageLookupByLibrary.simpleMessage("Leaves on"),
    "baroLeaving" : MessageLookupByLibrary.simpleMessage("Baro Ki\'Teer leaves in"),
    "baroLocation" : MessageLookupByLibrary.simpleMessage("Location"),
    "baroTitle" : MessageLookupByLibrary.simpleMessage("Void trader"),
    "bountyTitle" : MessageLookupByLibrary.simpleMessage("Bounties"),
    "cetusCycleTitle" : MessageLookupByLibrary.simpleMessage("Cetus Cycle"),
    "countdownTooltip" : m3,
    "earthCycleTitle" : MessageLookupByLibrary.simpleMessage("Earth Cycle"),
    "errorDescription" : MessageLookupByLibrary.simpleMessage("There was unexpected error in core system.\nReporting error to system admin..."),
    "errorTitle" : MessageLookupByLibrary.simpleMessage("An application error has occurred"),
    "eventDescription" : MessageLookupByLibrary.simpleMessage("Description"),
    "eventRewards" : MessageLookupByLibrary.simpleMessage("Rewards"),
    "eventStatus" : MessageLookupByLibrary.simpleMessage("Event Status"),
    "eventStatusEta" : MessageLookupByLibrary.simpleMessage("Time left (ETA)"),
    "eventStatusNode" : MessageLookupByLibrary.simpleMessage("Node"),
    "eventStatusProgress" : MessageLookupByLibrary.simpleMessage("Progress"),
    "fissuresTitle" : MessageLookupByLibrary.simpleMessage("Fissures"),
    "formorianTitle" : MessageLookupByLibrary.simpleMessage("Formorian"),
    "invasionsTitle" : MessageLookupByLibrary.simpleMessage("Invasions"),
    "kuvaBanner" : MessageLookupByLibrary.simpleMessage("Kuva will refresh in"),
    "locating" : MessageLookupByLibrary.simpleMessage("Locating..."),
    "razorbackTitle" : MessageLookupByLibrary.simpleMessage("Razerback"),
    "seeDetails" : MessageLookupByLibrary.simpleMessage("See details"),
    "syndicatesTitle" : MessageLookupByLibrary.simpleMessage("Syndicates"),
    "tapForMoreDetails" : MessageLookupByLibrary.simpleMessage("Tap for more details"),
    "timersTitle" : MessageLookupByLibrary.simpleMessage("Timers"),
    "vallisCycleTitle" : MessageLookupByLibrary.simpleMessage("Vallis Cycle")
  };
}
