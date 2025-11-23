import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key, required this.season, required this.days});

  final String season;
  final List<CalendarDay> days;

  @override
  Widget build(BuildContext context) {
    // final seasonColor = SeasonColors.color(season.toLowerCase())!;

    return Scaffold(
      appBar: AppBar(title: Text('1999 Calendar - $season')),
      body: CalendarView(days: days),
    );
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
                    MaterialLocalizations.of(context).formatMediumDate(days[index].day),
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

  final List<CalendarDayEvent> events;

  @override
  Widget build(BuildContext context) {
    IconData icon(CalendarEvents type) => switch (type) {
      .challenge => Icons.task_alt_rounded,
      .upgrade => Icons.settings_suggest_rounded,
      .reward => Icons.card_giftcard_rounded,
      .plot => Icons.cake_rounded,
    };

    Widget content(CalendarDayEvent event) => switch (event) {
      CalendarDayChallenge(title: final title, description: final description) => ListTile(
        title: Text(title),
        subtitle: Text(description),
      ),
      CalendarDayUpgrade(name: final name, description: final description) => ListTile(
        title: Text(name),
        subtitle: Text(description),
      ),
      CalendarDayReward(reward: final reward) => ListTile(title: Text(reward)),
      CalendarDayBirthday(conversation: final convo) => ListTile(
        title: Text(convo.replaceFirst('BirthdayConvo', "'s Birthday")),
      ),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon(events.first.type)),
          title: Text(events.first.type.translation, style: Theme.of(context).textTheme.titleMedium),
        ),
        ...events.map(content),
      ],
    );
  }
}
