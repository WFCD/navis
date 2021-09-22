import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef LoadWidget<S> = bool Function(S state);

class BlocBuilerProgressLoader<B extends BlocBase<S>, S>
    extends BlocBuilderBase<B, S> {
  const BlocBuilerProgressLoader({
    Key? key,
    required this.isLoaded,
    required this.builder,
    B? bloc,
    BlocBuilderCondition<S>? buildWhen,
  }) : super(key: key, bloc: bloc, buildWhen: buildWhen);

  final LoadWidget<S> isLoaded;
  final BlocWidgetBuilder<S> builder;

  @override
  Widget build(BuildContext context, S state) {
    if (isLoaded(state)) return builder(context, state);

    return const Center(child: CircularProgressIndicator());
  }
}
