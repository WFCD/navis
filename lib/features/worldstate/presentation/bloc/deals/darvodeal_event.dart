part of 'darvodeal_bloc.dart';

abstract class DarvodealEvent extends Equatable {
  const DarvodealEvent();

  @override
  List<Object> get props => [];
}

class LoadDarvodeal extends DarvodealEvent {
  const LoadDarvodeal(this.deal);

  final DarvoDeal deal;

  @override
  List<Object> get props => [deal];
}
