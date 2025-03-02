import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Alignment;

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key, required this.season, required this.days});

  final String season;
  final List<CalendarDay> days;

  @override
  Widget build(BuildContext context) {
    // final seasonColor = SeasonColors.color(season.toLowerCase())!;

    return Scaffold(appBar: AppBar(title: Text('1999 Calendar - $season')), body: CalendarView(days: days));
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key, required this.days});

  final List<CalendarDay> days;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) {
        return AppCard(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: EventContent(events: days[index].events),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    MaterialLocalizations.of(context).formatMediumDate(days[index].date),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EventContent extends StatelessWidget {
  const EventContent({super.key, required this.events});

  final List<CalendarEvent> events;

  @override
  Widget build(BuildContext context) {
    IconData icon(String type) => switch (type.toLowerCase()) {
      'to do' => Icons.task_alt_rounded,
      'override' => Icons.settings_suggest_rounded,
      'big prize!' => Icons.card_giftcard_rounded,
      'birthday' => Icons.cake_rounded,
      _ => WarframeSymbols.menu_LotusEmblem,
    };

    Widget content(CalendarEvent event) => switch (event) {
      CalendarChallenge() => ListTile(title: Text(event.challenge.title), subtitle: Text(event.challenge.description)),
      CalendarUpgrade() => ListTile(title: Text(event.upgrade.title), subtitle: Text(event.upgrade.description)),
      CalendarReward() => ListTile(title: Text(event.reward)),
      CalendarBirthday() => ListTile(title: Text(event.conversation.replaceFirst('BirthdayConvo', "'s Birthday"))),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon(events.first.type)),
          title: Text(events.first.type, style: Theme.of(context).textTheme.titleMedium),
        ),
        ...events.map(content),
      ],
    );
  }
}
