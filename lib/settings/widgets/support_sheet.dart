import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:warframe_icons/warframe_icons.dart';

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({super.key});

  static Future<void> showSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => const SupportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const radius = 15.0;
    const tobiahAvatar = 'https://storage.ko-fi.com/cdn/useruploads/4923dd47-8bfb-44f3-93a1-33d8b76c746f.png';
    final borderRadius = BorderRadius.circular(8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Material(
            color: const Color(0xFF5865F2),
            borderRadius: borderRadius,
            child: ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(SimpleIcons.discord),
              title: Text(context.l10n.appSupportTitle),
              subtitle: Text(context.l10n.appSupportSubtitle),
              onTap: () => discordInvite.launchLink(context),
            ),
          ),
          Material(
            color: const Color(0xFFCCCCCC),
            borderRadius: borderRadius,
            child: ListTile(
              textColor: Colors.grey[900],
              leading: CircleAvatar(
                backgroundColor: Colors.grey[900],
                radius: radius + 2,
                child: const CircleAvatar(
                  radius: radius,
                  backgroundImage: CachedNetworkImageProvider(tobiahAvatar),
                ),
              ),
              title: Text(context.l10n.supportTitle('Tobiah')),
              subtitle: Text(context.l10n.supportSubtitleTobiah),
              onTap: () => tobiahkofi.launchLink(context),
            ),
          ),
          Material(
            color: const Color(0xFF3F51B5),
            borderRadius: borderRadius,
            child: ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(WarframeIcons.nightmare, size: 30),
              title: Text(context.l10n.supportTitle('Cephalon Navis')),
              subtitle: Text(context.l10n.supportSubtitleNavis),
              onTap: () => buyMeCoffee.launchLink(context),
            ),
          ),
        ],
      ),
    );
  }
}
