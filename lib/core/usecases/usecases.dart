import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oxidized/oxidized.dart';

import '../error/failures.dart';

@immutable
abstract class Usecase<T extends Object, Params> {
  const Usecase();

  Future<Result<T, Failure>> call(Params params);
}

class NoParama extends Equatable {
  @override
  List<Object> get props => [];
}
