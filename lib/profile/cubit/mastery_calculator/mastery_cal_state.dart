part of 'mastery_cal_cubit.dart';

sealed class MasteryCalState extends Equatable {
  const MasteryCalState({required this.owned, required this.rank});

  final int owned;
  final int rank;

  bool get isLegendary => owned <= 2397500;

  int get current {
    return isLegendary
        ? 2250000 + (147500 * rank)
        : 2500 * (pow(rank, 2).floor());
  }

  int get next {
    return isLegendary
        ? 2250000 + (147500 * rank)
        : 2500 * (pow(rank + 1, 2).floor());
  }

  int get requiredForNext => next - rank;

  @override
  List<Object> get props => [rank, next];
}

final class MasteryInitial extends MasteryCalState {
  const MasteryInitial() : super(owned: 0, rank: 0);
}

final class MasteryCalculated extends MasteryCalState {
  const MasteryCalculated({required super.owned, required super.rank});
}

final class MasteryFailure extends MasteryCalState {
  const MasteryFailure(this.message) : super(owned: 0, rank: 0);

  final String message;

  @override
  List<Object> get props => [message];
}
