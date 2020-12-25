import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/solsystem_bloc.dart';

class RefreshIndicatorBlocScreen extends StatelessWidget {
  const RefreshIndicatorBlocScreen({Key key, this.builder}) : super(key: key);

  final BlocWidgetBuilder<SolsystemState> builder;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<SolsystemBloc>(context).update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: builder,
      ),
    );
  }
}
