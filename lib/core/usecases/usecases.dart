import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../error/failures.dart';

@immutable
abstract class Usecase<Type, Params> {
  const Usecase();

  Future<Either<Failure, Type>> call(Params params);
}

class NoParama extends Equatable {
  @override
  List<Object> get props => [];
}
