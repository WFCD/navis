import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({super.key, required this.news});

  final OrbiterNews news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;

    return InkWell(
      onTap: () => news.link.launchLink(context),
      child: SizedBox(
        height: 200,
        child: Theme(
          data: NavisThemes.dark,
          child: Card(
            child: BackgroundImage(
              imageUrl: news.proxyImage,
              child: ListTile(
                title: Text(
                  news.translations[currentLocale] ?? news.message,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  MaterialLocalizations.of(context)
                      .formatFullDate(news.date.toLocal()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
