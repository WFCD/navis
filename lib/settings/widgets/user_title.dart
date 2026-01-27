import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:warframe_icons/warframe_icons.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({super.key, required this.avatar, required this.username, required this.rank});

  final String avatar;
  final String username;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'[\ue000-\ue008]', unicode: true);
    final name = username.replaceAll(regex, '');
    final platform = regex.stringMatch(username);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(radius: 29, foregroundImage: CachedNetworkImageProvider(avatar)),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Text(name),
          if (platform != null) _PlatformIcon(platform: platform),
        ],
      ),
      subtitle: Text(context.l10n.itemRankSubtitle(rank)),
    );
  }
}

class _PlatformIcon extends StatelessWidget {
  const _PlatformIcon({required this.platform});

  final String platform;

  @override
  Widget build(BuildContext context) {
    // \ue000 - pc
    // \ue001 - xbox
    // \ue002 - ps
    // \ue003 - switch
    // \ue004 - ios

    const pc = 'PC';
    const psn = 'Sony PlayStation';
    const xbl = 'Microsoft Xbox';
    const swi = 'Nintendo Switch';
    const ios = 'Apple iOS';

    final isDark = context.theme.isDark;

    // The offical brand guidline just white or black
    final steamColor = isDark ? Colors.white : Colors.black;

    // Based of the brand guidlines for the PSs
    final psnColor = isDark ? const Color(0xFF0070CC) : const Color(0xFF00439C);

    // Couldn't find a recent official color so 2019 it is
    const xboxColor = Color(0xFF107C10);

    // Out of all of these guys and nintendo had better docs... NINTENDO!!
    const swiColor = Color(0xFFe60012);

    final codepoint = platform.codeUnitAt(0).toRadixString(16);

    return switch (int.parse(codepoint[codepoint.length - 1])) {
      0 => Icon(SimpleIcons.steam, color: steamColor, semanticLabel: pc),
      // Gonna hope nobody at MS uses this app https://github.com/simple-icons/simple-icons/pull/10019
      1 => const Icon(SimpleIcons.xbox, color: xboxColor, semanticLabel: xbl),
      2 => Icon(SimpleIcons.playstation, color: psnColor, semanticLabel: psn),
      3 => const Icon(SimpleIcons.nintendo, color: swiColor, semanticLabel: swi),
      // https://www.apple.com/legal/sales-support/certification/docs/logo_guidelines.pdf
      4 => Icon(SimpleIcons.apple, color: steamColor, semanticLabel: ios),
      _ => const Icon(WarframeIcons.nightmare),
    };
  }
}
