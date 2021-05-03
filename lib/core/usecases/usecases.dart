import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oxidized/oxidized.dart';

import '../error/failures.dart';

@immutable
abstract class Usecase<Type, Params> {
  const Usecase();

  Future<Result<Type, Failure>> call(Params params);
}

class NoParama extends Equatable {
  @override
  List<Object> get props => [];
}
