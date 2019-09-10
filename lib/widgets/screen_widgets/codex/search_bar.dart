import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/search/search_utils.dart';

import 'search_results_sort.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _active = false;
  TextEditingController _textEditingController;

  void _clearListener() {
    final searching = _textEditingController.text.isNotEmpty;

    if (mounted && _active != searching) {
      setState(() => _active = searching);
    }
  }

  @override
  void initState() {
    _textEditingController = TextEditingController()
      ..addListener(_clearListener);

    super.initState();
  }

  List<PopupMenuItem<SearchTypes>> _buildItems(BuildContext context) {
    return SearchTypes.values.map((v) {
      final option = toBeginningOfSentenceCase(v.toString().split('.').last);

      return PopupMenuItem<SearchTypes>(child: Text(option), value: v);
    }).toList();
  }

  void _onSelected(SearchTypes next, SearchTypes previous) {
    if (next != null && next != previous) {
      if (_textEditingController.text.isNotEmpty) {
        _onClear();
      }

      BlocProvider.of<SearchBloc>(context).dispatch(SwitchSearchType(next));

      setState(() {});
    }
  }

  void _dispatch(String text) {
    BlocProvider.of<SearchBloc>(context).dispatch(TextChanged(text));
  }

  void _onClear() {
    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<SearchBloc>(context).dispatch(TextChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    final type = BlocProvider.of<SearchBloc>(context).searchType;

    return SliverPadding(
      padding: const EdgeInsets.only(top: 8.0),
      sliver: SliverFloatingBar(
        elevation: 8.0,
        automaticallyImplyLeading: false,
        floating: true,
        snap: true,
        backgroundColor: Theme.of(context).cardColor,
        title: TextField(
          controller: _textEditingController,
          autocorrect: false,
          onChanged: _dispatch,
          onSubmitted: _dispatch,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search here...',
          ),
        ),
        trailing: LimitedBox(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_active)
                    IconButton(icon: Icon(Icons.clear), onPressed: _onClear),
                  if (type == SearchTypes.drops) const SearchResultsSort(),
                  PopupMenuButton<SearchTypes>(
                    initialValue: type,
                    itemBuilder: _buildItems,
                    onSelected: (t) => _onSelected(t, type),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }
}
