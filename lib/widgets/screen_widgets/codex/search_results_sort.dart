import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_utils.dart';

class SearchResultsSort extends StatelessWidget {
  const SearchResultsSort({Key key}) : super(key: key);

  List<PopupMenuItem<Sort>> _itemBuilder() {
    return Sort.values.map((v) {
      final option = v.toString().split('.').last.replaceAll('_', ' to ');

      return PopupMenuItem(
          child: Text(toBeginningOfSentenceCase(option)), value: v);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        final type = state is SearchStateSuccess ? state.sortBy : null;

        return PopupMenuButton<Sort>(
          initialValue: type,
          icon: Icon(Icons.sort),
          itemBuilder: (_) => _itemBuilder(),
          enabled: state is SearchStateSuccess,
          onSelected: (s) {
            if (state is SearchStateSuccess) {
              if (s != state.sortBy) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SortSearch(s, state.results));
              }
            }
          },
        );
      },
    );
  }
}
