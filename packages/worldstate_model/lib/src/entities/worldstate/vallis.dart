import 'package:worldstate_api_model/src/objects/cycle_object.dart';

class Vallis extends CycleObject {
  const Vallis({
    String id,
    DateTime activation,
    DateTime expiry,
    String state,
    this.isWarm,
  }) : super(id: id, activation: activation, expiry: expiry, state: state);

  final bool isWarm;

  @override
  bool get getStateBool => isWarm;

  @override
  String get nextState => !isWarm ? 'warm' : 'cold';

  @override
  List<Object> get props => super.props..add(isWarm);
}
