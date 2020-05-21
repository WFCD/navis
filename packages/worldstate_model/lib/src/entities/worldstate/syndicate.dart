import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

import 'job.dart';

class Syndicate extends WorldstateObject {
  const Syndicate({
    String id,
    DateTime activation,
    DateTime expiry,
    this.name,
    this.active,
    this.jobs,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String name;
  final bool active;
  final List<Job> jobs;

  @override
  List<Object> get props => super.props..addAll([name, active, jobs]);
}
