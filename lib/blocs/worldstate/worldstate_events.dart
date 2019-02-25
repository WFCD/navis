import 'package:equatable/equatable.dart';

abstract class StateEvent extends Equatable {}

class UpdateState extends StateEvent {}
