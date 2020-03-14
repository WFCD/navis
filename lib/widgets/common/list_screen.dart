import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({
    Key key,
    @required this.state,
    @required this.items,
    @required this.noItemsText,
  })  : assert(state != null),
        assert(items != null),
        assert(noItemsText != null),
        super(key: key);

  final WorldStates state;
  final List<Widget> items;
  final String noItemsText;

  Widget _buildList() {
    return ListView.builder(
      itemCount: items.length,
      cacheExtent: 500,
      itemBuilder: (BuildContext context, int index) => items[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    final empty = Center(child: Text(noItemsText));
    const loading = Center(child: CircularProgressIndicator());

    final crossFadeState = state is WorldstateLoaded
        ? CrossFadeState.showSecond
        : CrossFadeState.showFirst;

    return RefreshIndicator(
      onRefresh: BlocProvider.of<WorldstateBloc>(context).update,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        crossFadeState: crossFadeState,
        firstChild: loading,
        secondChild: items.isNotEmpty ? _buildList() : empty,
      ),
    );
  }
}
