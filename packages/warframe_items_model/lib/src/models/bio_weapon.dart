import 'package:json_annotation/json_annotation.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'base_item.dart';

part 'bio_weapon.g.dart';

@JsonSerializable()
class BioWeapon extends BaseItem {
  const BioWeapon({
    String uniqueName,
    String name,
    String description,
    this.aura,
    this.health,
    this.shield,
    this.armor,
    this.power,
    this.masteryReq,
    this.sprintSpeed,
    this.passiveDescription,
    this.abilities,
    this.buildPrice,
    this.buildTime,
    this.skipBuildTimePrice,
    this.buildQuantity,
    this.consumeOnBuild,
    this.components,
    String type,
    String imageName,
    String category,
    bool tradable,
    List<Patchlog> patchlogs,
    String wikiaThumbnail,
    String wikiaUrl,
    this.sex,
    this.introduced,
    this.polarities,
    this.color,
  }) : super(
          uniqueName: uniqueName,
          name: name,
          description: description,
          type: type,
          imageName: imageName,
          category: category,
          tradable: tradable,
          patchlogs: patchlogs,
          wikiaThumbnail: wikiaThumbnail,
          wikiaUrl: wikiaUrl,
        );

  factory BioWeapon.fromJson(Map<String, dynamic> json) {
    return _$BioWeaponFromJson(json);
  }

  final String aura;
  final int health, shield, armor, power, masteryReq;
  final double sprintSpeed;
  final int buildPrice, buildTime, skipBuildTimePrice, buildQuantity;
  final bool consumeOnBuild;
  final List<Component> components;
  final List<Ability> abilities;
  final List<String> polarities;
  final String passiveDescription, introduced, sex;
  final int color;

  @override
  Map<String, dynamic> toJson() => _$BioWeaponToJson(this);

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        aura,
        health,
        shield,
        armor,
        power,
        masteryReq,
        sprintSpeed,
        buildPrice,
        buildTime,
        skipBuildTimePrice,
        buildQuantity,
        consumeOnBuild,
        components,
        abilities,
        polarities,
        passiveDescription,
        introduced,
        sex,
        color
      ]);
  }
}
