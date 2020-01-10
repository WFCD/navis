import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/scaffold/error_page.dart';

class ScaffoldListenerWidget extends StatelessWidget {
  const ScaffoldListenerWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      builder: (BuildContext context, WorldStates state) {
        if (state is WorldstateLoadFailure)
          return NetworkErrorWidget(exception: state.error);

        return child;
      },
    );
  }
}
