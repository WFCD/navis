part of 'mastery_cubit.dart';

sealed class MasteryProgressState extends Equatable {
  const MasteryProgressState();

  @override
  List<Object> get props => [];
}

final class MasteryProgressInitial extends MasteryProgressState {}

final class MasteryProgressSuccess extends MasteryProgressState {
  const MasteryProgressSuccess(this.items);

  final List<MasterableItem> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'MasteryProgressSuccess(items: ${items.length})';
}

final class MasteryProgressFailure extends MasteryProgressState {}
