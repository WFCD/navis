import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  const Reward({
    this.itemString,
    this.thumbnail,
    this.asString,
    this.credits,
    this.countedItems,
  });

  final String itemString, thumbnail, asString;
  final int credits;
  final List<CountedItem> countedItems;

  @override
  List<Object> get props {
    return [
      itemString,
      thumbnail,
      asString,
      credits,
      countedItems,
    ];
  }
}

class CountedItem extends Equatable {
  const CountedItem({this.count, this.type});

  final num count;
  final String type;

  @override
  List<Object> get props => [count, type];
}
