import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/preinstalled_polarities.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Polarity;

class FrameStats extends StatelessWidget {
  const FrameStats({super.key, required this.powerSuit});

  final PowerSuit powerSuit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CategoryTitle(title: context.l10n.statsTitle, contentPadding: EdgeInsets.zero),
        Stats(
          stats: <RowItem>[
            if (powerSuit is Warframe && (powerSuit as Warframe).aura != null)
              RowItem(
                text: Text(l10n.auraTitle),
                child: Polarity(polarity: (powerSuit as Warframe).aura!),
              ),
            if (powerSuit.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(polarities: powerSuit.polarities!),
              ),
            RowItem(text: Text(l10n.shieldTitle), child: Text('${powerSuit.shield}')),
            RowItem(text: Text(l10n.armorTitle), child: Text('${powerSuit.armor}')),
            RowItem(text: Text(l10n.healthTitle), child: Text('${powerSuit.health}')),
            RowItem(text: Text(l10n.powerTitle), child: Text('${powerSuit.power}')),
            if (powerSuit is Warframe)
              RowItem(
                text: Text(l10n.sprintSpeedTitle),
                child: Text((powerSuit as Warframe).sprintSpeed.toStringAsFixed(2)),
              ),
          ],
        ),
        Gaps.gap16,
        if (powerSuit is Warframe && (powerSuit as Warframe).passiveDescription != null)
          ListTile(
            title: Text(context.l10n.warframePassiveTitle),
            subtitle: Text((powerSuit as Warframe).passiveDescription!),
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          ),
        _Abilities(abilities: powerSuit.abilities),
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
