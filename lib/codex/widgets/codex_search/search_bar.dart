import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/bloc/search_bloc.dart';
import 'package:navis/codex/utils/result_filters.dart';

class CodexTextEditior extends StatefulWidget {
  const CodexTextEditior({Key? key}) : super(key: key);

  @override
  _CodexTextEditiorState createState() => _CodexTextEditiorState();
}

class _CodexTextEditiorState extends State<CodexTextEditior> {
  bool _active = false;

  late SearchBloc _searchBloc;
  late TextEditingController _textEditingController;

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
    FocusScope.of(context).requestFocus();
    _searchBloc.add(const SearchCodex(''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _textEditingController,
                  autocorrect: false,
                  onChanged: _dispatch,
                  onSubmitted: _dispatch,
                  cursorColor: Theme.of(context).textTheme.bodyText1?.color,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search here...',
                  ),
                ),
              ),
            ),
            if (state is CodexSuccessfulSearch)
              PopupMenuButton<FilterCategory>(
                icon: const Icon(Icons.filter_list),
                itemBuilder: (context) {
                  return FilterCategories.categories
                      .map(
                        (e) => PopupMenuItem<FilterCategory>(
                          value: e,
                          child: Text(e.category),
                        ),
                      )
                      .toList();
                },
                onSelected: (s) =>
                    BlocProvider.of<SearchBloc>(context).add(FilterResults(s)),
              ),
            if (_active)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _onClear,
              ),
          ],
        );
      },
    );
  }
}
