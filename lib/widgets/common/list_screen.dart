import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:worldstate_api_model/objects.dart';

typedef BuildWorldstateObjectWidget<T extends WorldstateObject> = Widget
    Function(BuildContext context, T object);

class ListScreen<T extends WorldstateObject> extends StatelessWidget {
  const ListScreen({
    Key key,
    @required this.state,
    @required this.emptyList,
    @required this.items,
    @required this.buildWidget,
  })  : assert(state != null),
        assert(items != null),
        assert(emptyList != null),
        super(key: key);

  final WorldStates state;
  final String emptyList;
  final List<T> items;
  final BuildWorldstateObjectWidget<T> buildWidget;

  Widget _buildList() {
    return ImplicitlyAnimatedList<T>(
      items: items,
      areItemsTheSame: (a, b) => a.id == b.id,
      insertDuration: const Duration(milliseconds: 250),
      removeDuration: const Duration(milliseconds: 250),
      itemBuilder: (BuildContext context, Animation<double> animation, T object,
          int index) {
        return SizeFadeTransition(
          animation: animation,
          sizeFraction: 0.7,
          child: buildWidget(context, object),
        );
      },
      removeItemBuilder:
          (BuildContext context, Animation<double> animation, T object) {
        return FadeTransition(
          opacity: animation,
          child: buildWidget(context, object),
        );
      },
    );

    // return ListView.builder(
    //   itemCount: items.length,
    //   cacheExtent: extent * (items.length / 3),
    //   itemBuilder: (BuildContext context, int index) => items[index],
    // );
  }

  @override
  Widget build(BuildContext context) {
    final empty = Center(child: Text(emptyList));
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
