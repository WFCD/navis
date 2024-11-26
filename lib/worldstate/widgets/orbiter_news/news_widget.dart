import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/gen/assets.gen.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return AppCard(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: context.theme.colorScheme.secondaryContainer,
      child: InkWell(
        onTap: () => news.link.launchLink(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _NewsImage(imageUrl: news.imageLink),
            ListTile(
              title: Text(
                news.translations[currentLocale] ?? news.message,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: colorScheme.onSecondaryContainer),
              ),
              subtitle: Text(
                MaterialLocalizations.of(context)
                    .formatFullDate(news.date.toLocal()),
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer.withOpacity(.7),
                ),
              ),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  const _NewsImage({required this.imageUrl});

  final String imageUrl;

  Image get _placeholder {
    return Image(
      image: Assets.derelict.provider(),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.sizeOf(context).shortestSide,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => _placeholder,
          errorWidget: (context, url, dynamic error) => _placeholder,
        ),
      ),
    );
  }
}
