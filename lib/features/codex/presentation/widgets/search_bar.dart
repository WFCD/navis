import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/codex/presentation/bloc/search_state.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class CodexSearchBar extends StatefulWidget {
  const CodexSearchBar({Key key}) : super(key: key);

  @override
  _CodexSearchBarState createState() => _CodexSearchBarState();
}

class _CodexSearchBarState extends State<CodexSearchBar> {
  bool _active = false;

  SearchBloc _searchBloc;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(_clearListener);

    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  void _clearListener() {
    final searching = _textEditingController.text.isNotEmpty;

    if (mounted && _active != searching) {
      setState(() => _active = searching);
    }
  }

  void _dispatch(String text) {
    _searchBloc.add(SearchCodex(text));
  }

  void _onClear() {
    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    _searchBloc.add(const SearchCodex(''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _textEditingController,
                autocorrect: false,
                onChanged: _dispatch,
                onSubmitted: _dispatch,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here...',
                ),
              ),
            ),
          ),
          if (state is CodexSuccessfulSearch)
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list),
              itemBuilder: (context) {
                return FilterCategories.categories
                    .map((e) => PopupMenuItem<String>(value: e, child: Text(e)))
                    .toList();
              },
              onSelected: (s) => _searchBloc.add(SearchFilter(s)),
            ),
          if (_active)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _onClear,
            ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }
}
