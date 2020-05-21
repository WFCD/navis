import 'package:worldstate_api_model/src/objects/cycle_object.dart';

class Earth extends CycleObject {
  const Earth({
    String id,
    DateTime activation,
    DateTime expiry,
    String state,
    this.isDay,
    this.isCetus,
  }) : super(id: id, activation: activation, expiry: expiry, state: state);

  final bool isDay;
  final bool isCetus;

  @override
  bool get getStateBool => isDay;

  @override
  String get nextState => !isDay ? 'Day' : 'Night';

  @override
  List<Object> get props => super.props..add(isDay);
}
