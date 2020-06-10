import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/injection_container.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class CodexSearchBar extends StatefulWidget {
  const CodexSearchBar({Key key}) : super(key: key);

  @override
  _CodexSearchBarState createState() => _CodexSearchBarState();
}

class _CodexSearchBarState extends State<CodexSearchBar> {
  bool _active = false;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(_clearListener);
  }

  void _clearListener() {
    final searching = _textEditingController.text.isNotEmpty;

    if (mounted && _active != searching) {
      setState(() => _active = searching);
    }
  }

  void _dispatch(String text) {
    BlocProvider.of<SearchBloc>(context).add(SearchCodex(text));
  }

  void _onClear() {
    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<SearchBloc>(context).add(const SearchCodex(''));
  }

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search here...',
              ),
            ),
          ),
        ),
        if (_active)
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _onClear,
          ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }
}
