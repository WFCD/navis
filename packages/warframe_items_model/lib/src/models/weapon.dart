import 'package:json_annotation/json_annotation.dart';
import 'package:warframe_items_model/src/common/component.dart';

import 'base_item.dart';

part 'weapon.g.dart';

@JsonSerializable()
class Weapon extends BaseItem {
  const Weapon({
    String uniqueName,
    String name,
    String description,
    String type,
    String imageName,
    String category,
    bool tradable,
    String wikiaThumbnail,
    String wikiaUrl,
    this.secondsPerShot,
    this.damagePerShot,
    this.magazineSize,
    this.reloadTime,
    this.totalDamage,
    this.damagePerSecond,
    this.trigger,
    this.accuracy,
    this.criticalChance,
    this.criticalMultiplier,
    this.procChance,
    this.fireRate,
    this.chargeAttack,
    this.spinAttack,
    this.leapAttack,
    this.wallAttack,
    this.slot,
    this.noise,
    this.sentinel,
    this.masteryReq,
    this.omegaAttenuation,
    this.channelingDrain,
    this.channelingDamagemultiplier,
    this.buildPrice,
    this.buildTime,
    this.skipBuildTime,
    this.buildQuantity,
    this.consumeOnBuild,
    this.components,
    this.damage,
    this.damageTypes,
    this.marketCost,
    this.polarites,
    this.tags,
    this.vaulted,
    this.disposition,
  }) : super(
          uniqueName: uniqueName,
          name: name,
          description: description,
          type: type,
          imageName: imageName,
          category: category,
          tradable: tradable,
          wikiaUrl: wikiaUrl,
          wikiaThumbnail: wikiaThumbnail,
        );

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  final num secondsPerShot;
  final List<num> damagePerShot;
  final num magazineSize;
  final num reloadTime;
  final num totalDamage;
  final num damagePerSecond;
  final String trigger;
  final num accuracy;
  final num criticalChance, criticalMultiplier, procChance;
  final num fireRate;
  final num chargeAttack, spinAttack, leapAttack, wallAttack;
  final num slot;
  final String noise;
  final bool sentinel;
  final num masteryReq;
  final num omegaAttenuation;
  final num channelingDrain, channelingDamagemultiplier;
  final num buildPrice, buildTime, skipBuildTime, buildQuantity;
  final bool consumeOnBuild;
  final List<Component> components;
  final dynamic damage;
  final Map<String, dynamic> damageTypes;
  final dynamic marketCost;
  final List<String> polarites, tags;
  final bool vaulted;
  final num disposition;

  @override
  Map<String, dynamic> toJson() => _$WeaponToJson(this);

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        secondsPerShot,
        damagePerShot,
        magazineSize,
        reloadTime,
        totalDamage,
        damagePerSecond,
        trigger,
        accuracy,
        criticalChance,
        criticalMultiplier,
        procChance,
        fireRate,
        chargeAttack,
        spinAttack,
        leapAttack,
        wallAttack,
        slot,
        noise,
        sentinel,
        masteryReq,
        omegaAttenuation,
        channelingDrain,
        channelingDamagemultiplier,
        buildPrice,
        buildTime,
        skipBuildTime,
        buildQuantity,
        consumeOnBuild,
        components,
        damage,
        damageTypes,
        marketCost,
        polarites,
        tags,
        vaulted,
        disposition,
      ]);
  }
}
