part of 'darvodeal_bloc.dart';

abstract class DarvodealState extends Equatable {
  const DarvodealState();

  @override
  List<Object> get props => [];
}

class DarvodealInitial extends DarvodealState {}

class DarvodealLoading extends DarvodealState {}

class DarvoDealLoaded extends DarvodealState {
  const DarvoDealLoaded(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}
