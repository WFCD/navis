import 'package:navis/resources/resources.dart';

const _common = 'Common';
const _uncommon = 'Uncommon';
const _rare = 'Rare';
const _legendary = 'Legendary';

const _madurai = 'Madurai';
const _vazarin = 'Vazarin';
const _naramon = 'Naramon';
const _zenurik = 'Zenurik';
const _unairu = 'Unairu';
const _penjaga = 'Penjaga';
const _umbra = 'Umbra';

String getPolarity(String rarity, String polarity) {
  if (rarity == _common) {
    switch (polarity) {
      case _madurai:
        return ModFrames.bronzePolarityTriangle;
      case _vazarin:
        return ModFrames.bronzePolarityPoint;
      case _naramon:
        return ModFrames.bronzePolarityCircle;
      case _zenurik:
        return ModFrames.bronzePolarityMark;
      case _unairu:
        return ModFrames.bronzeUnairu;
      case _penjaga:
        return ModFrames.bronzePolarityPrecept;
    }
  } else if (rarity == _uncommon || rarity == _legendary) {
    switch (polarity) {
      case _madurai:
        return ModFrames.polarityTriangle;
      case _vazarin:
        return ModFrames.polarityPoint;
      case _naramon:
        return ModFrames.polarityCircle;
      case _zenurik:
        return ModFrames.polarityMark;
      case _unairu:
        return ModFrames.unairu;
      case _penjaga:
        return ModFrames.polarityPrecept;
      case _umbra:
        return ModFrames.polarityUmbra;
    }
  } else if (rarity == _rare) {
    switch (polarity) {
      case _madurai:
        return ModFrames.rarePolarityTriangle;
      case _vazarin:
        return ModFrames.rarePolarityPoint;
      case _naramon:
        return ModFrames.rarePolarityCircle;
      case _zenurik:
        return ModFrames.rarePolarityMark;
      case _unairu:
        return ModFrames.rareUnairu;
      case _penjaga:
        return ModFrames.rarePolarityPrecept;
    }
  }


  return ModFrames.bronzePolarityTriangle;
}
