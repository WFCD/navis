import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class Usecase<Type, Params> {
  const Usecase();

  Future<Type> call(Params params);
}

class NoParama extends Equatable {
  @override
  List<Object> get props => [];
}
