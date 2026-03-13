part of 'arbitration_cubit.dart';

sealed class ArbitrationState extends Equatable {
  const ArbitrationState();

  @override
  List<Object> get props => [];
}

final class ArbitrationInitial extends ArbitrationState {}

final class ArbitrationActive extends ArbitrationState {
  const ArbitrationActive({required this.arbitration});

  // ignore: experimental_member_use Good for now
  final Arbitration arbitration;

  @override
  List<Object> get props => [arbitration];

  @override
  String toString() => 'ArbitrationActive(${arbitration.id})';
}
