import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => news.link.launchLink(context),
        child: SizedBox(
          height: 200,
          child: BackgroundImage(
            imageUrl: news.imageLink,
            child: ListTile(
              title: Text(
                news.translations[currentLocale] ?? news.message,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                MaterialLocalizations.of(context)
                    .formatFullDate(news.date.toLocal()),
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
