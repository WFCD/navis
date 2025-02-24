import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/gen/assets.gen.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class OrbiterNewsCard extends StatelessWidget {
  const OrbiterNewsCard({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: context.theme.colorScheme.secondaryContainer,
      child: InkWell(onTap: () => news.link.launchLink(context), child: OrbiterNewsContent(news: news)),
    );
  }
}

class OrbiterNewsContent extends StatelessWidget {
  const OrbiterNewsContent({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: _NewsImage(imageUrl: news.imageLink)),
        ListTile(
          title: Text(
            news.translations[currentLocale] ?? news.message,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSecondaryContainer),
          ),
          subtitle: Text(
            MaterialLocalizations.of(context).formatFullDate(news.date.toLocal()),
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSecondaryContainer.withValues(alpha: .7),
            ),
          ),
          dense: true,
        ),
      ],
    );
  }
}

class _NewsImage extends StatelessWidget {
  const _NewsImage({required this.imageUrl});

  final String imageUrl;

  Image _placeholder(double width, double height) {
    return Image(
      image: ResizeImage(Assets.derelict.provider(), width: width.toInt(), height: height.toInt()),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: BoxFit.cover,
            placeholder: (context, url) => _placeholder(width, height),
            errorWidget: (context, url, dynamic error) => _placeholder(width, height),
          ),
        );
      },
    );
  }
}
