import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class SearchResultsSort extends StatelessWidget {
  SearchResultsSort({Key key}) : super(key: key);

  final _iconKey = GlobalKey();

  RelativeRect _getIconPosition(BuildContext context) {
    final RenderBox icon = _iconKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        icon.localToGlobal(icon.size.center(Offset.zero), ancestor: overlay),
        icon.localToGlobal(icon.size.center(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return position;
  }

  Future<void> _onPressed(
      BuildContext context, SearchBloc bloc, Sort value) async {
    final selected = await showMenu<Sort>(
      context: context,
      position: _getIconPosition(context),
      initialValue: value,
      items: [
        PopupMenuItem(
          child: const Text('Sort by A-Z'),
          value: Sort.ab,
        ),
        PopupMenuItem(
          child: const Text('Sort from highest-lowest chance'),
          value: Sort.hl,
        ),
        PopupMenuItem(
          child: const Text('Sort from lowest-highest chance'),
          value: Sort.lh,
        )
      ],
    );

    final currentState = bloc.currentState;

    if (currentState is SearchStateSuccess && currentState.sortBy != selected) {
      bloc.dispatch(SortSearch(selected, currentState.results));
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return IconButton(
          key: _iconKey,
          icon: Icon(Icons.sort),
          onPressed: state is SearchStateSuccess
              ? () => _onPressed(context, searchBloc, state.sortBy)
              : null,
        );
      },
    );
  }
}
