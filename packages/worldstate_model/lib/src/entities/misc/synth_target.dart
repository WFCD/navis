import 'package:equatable/equatable.dart';

import 'synth_location.dart';

class SynthTarget extends Equatable {
  const SynthTarget({this.name, this.locations});

  final String name;
  final List<SynthLocation> locations;

  @override
  List<Object> get props => [name, locations];
}
