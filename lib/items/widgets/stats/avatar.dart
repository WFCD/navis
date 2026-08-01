import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/items/widgets/stats/polarity.dart';
import 'package:navis/items/widgets/stats/preinstalled_polarities.dart';
import 'package:navis/items/widgets/stats/stats_column.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' hide Polarity;

class AvatarStats extends StatelessWidget {
  const AvatarStats({super.key, required this.avatar});

  final PowerSuit avatar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final aura = switch (avatar) {
      Warframe(:final aura) => aura,
      _ => null,
    };

    final sprintSpeed = switch (avatar) {
      Warframe(:final sprintSpeed) => sprintSpeed,
      _ => null,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CategoryTitle(title: context.l10n.statsTitle, contentPadding: EdgeInsets.zero),
        StatsColumn(
          stats: [
            Stat(
              name: Text(l10n.auraTitle),
              value: aura != null ? Polarity(polarity: aura) : const SizedBox.shrink(),
              isVisible: aura != null,
            ),
            Stat(
              name: Text(l10n.preinstalledPolarities),
              value: PreinstalledPolarties(polarities: avatar.polarities!),
              isVisible: avatar.polarities?.isNotEmpty ?? false,
            ),
            Stat(name: Text(l10n.shieldTitle), value: Text('${avatar.shield}')),
            Stat(name: Text(l10n.armorTitle), value: Text('${avatar.armor}')),
            Stat(name: Text(l10n.healthTitle), value: Text('${avatar.health}')),
            Stat(name: Text(l10n.powerTitle), value: Text('${avatar.power}')),
            Stat(
              name: Text(l10n.sprintSpeedTitle),
              value: sprintSpeed != null ? Text(sprintSpeed.toStringAsFixed(2)) : const SizedBox.shrink(),
              isVisible: avatar is Warframe,
            ),
          ],
        ),
        Gaps.gap16,
        if (avatar case Warframe(:final passiveDescription) when passiveDescription != null)
          ListTile(
            title: Text(context.l10n.warframePassiveTitle),
            subtitle: Text(passiveDescription),
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          ),
        _Abilities(abilities: avatar.abilities),
      ],
    );
  }
}

class _Abilities extends StatefulWidget {
  const _Abilities({required this.abilities});

  final List<Ability> abilities;

  @override
  State<_Abilities> createState() => _AbilitiesState();
}

class _AbilitiesState extends State<_Abilities> {
  Ability? _ability;

  void _onTap(Ability a) {
    if (!mounted) return;
    setState(() {
      if (a == _ability) {
        _ability = null;
        return;
      }

      _ability = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.abilities
                .map(
                  (a) => _AbilityIcon(
                    ability: a,
                    isSelected: _ability?.name == a.name,
                    onTap: () => _onTap(a),
                  ),
                )
                .toList(),
          ),
        ),
        if (_ability != null)
          Card(
            color: context.theme.colorScheme.secondaryContainer,
            child: ListTile(
              title: Text(_ability!.name),
              subtitle: Text(_ability!.description),
              titleTextStyle: context.textTheme.titleMedium?.copyWith(color: colorScheme.onSecondaryContainer),
              subtitleTextStyle: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryContainer.withAlpha(160),
              ),
            ),
          ),
      ],
    );
  }
}

class _AbilityIcon extends StatelessWidget {
  const _AbilityIcon({
    required this.ability,
    required this.isSelected,
    required this.onTap,
  });

  final Ability ability;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    const defaultIconSize = 10.0;
    final color = isSelected ? context.theme.colorScheme.secondary : context.theme.colorScheme.onSurface;

    return IconButton(
      onPressed: onTap,
      icon: CachedNetworkImage(
        imageUrl: ability.imageName.warframeItemsCdn().optimize(
          width: (defaultIconSize * 2.5).round(),
          pixelRatio: MediaQuery.devicePixelRatioOf(context),
        ),
        errorWidget: (context, str, obj) => Icon(WarframeIcons.nightmare, size: 60, color: color),
        color: color,
      ),
    );
  }
}
