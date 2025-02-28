import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Alignment;

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key, required this.season, required this.days});

  final String season;
  final List<CalendarDay> days;

  @override
  Widget build(BuildContext context) {
    final seasonColor = SeasonColors.color(season.toLowerCase())!;

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seasonColor, brightness: Theme.of(context).brightness),
      ),
      child: Scaffold(appBar: AppBar(title: Text('1999 Calendar - $season')), body: CalendarView(days: days)),
    );
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key, required this.days});

  final List<CalendarDay> days;

  Widget _eventContent(CalendarEvent event) {
    return switch (event) {
      CalendarChallenge() => ListTile(
        title: Text(event.type),
        subtitle: Text('${event.challenge.title}\n${event.challenge.description}'),
      ),
      CalendarUpgrade() => ListTile(
        title: Text(event.type),
        subtitle: Text('${event.upgrade.title}\n${event.upgrade.description}'),
      ),
      CalendarReward() => ListTile(title: Text(event.type), subtitle: Text(event.reward)),
      CalendarBirthday() => ListTile(
        title: const Text('Birthday'),
        subtitle: Text(event.conversation.replaceFirst('BirthdayConvo', "'s Birthday")),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) {
        return AppCard(
          child: Column(
            children: [
              for (final day in days[index].events) _eventContent(day),
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
