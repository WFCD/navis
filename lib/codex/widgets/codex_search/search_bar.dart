// These will start late regardless.
// ignore_for_file: avoid-late-keyword
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/bloc/search_bloc.dart';
import 'package:navis/codex/utils/result_filters.dart';

class CodexTextEditior extends StatefulWidget {
  const CodexTextEditior({super.key});

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

  List<PopupMenuEntry<FilterCategory>> _itemBuilder() {
    return FilterCategories.categories
        .map(
          (e) => PopupMenuItem<FilterCategory>(
            value: e,
            child: Text(e.category),
          ),
        )
        .toList();
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
                  // We actually want the same thing to happen on change and on
                  // submission.
                  // ignore: no-equal-arguments
                  onSubmitted: _dispatch,
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: Colors.white),
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: context.textTheme.subtitle2
                        ?.copyWith(color: Colors.white38),
                    hintText: 'Search here...',
                  ),
                ),
              ),
            ),
            if (state is CodexSuccessfulSearch)
              PopupMenuButton<FilterCategory>(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                itemBuilder: (_) => _itemBuilder(),
                onSelected: (s) =>
                    BlocProvider.of<SearchBloc>(context).add(FilterResults(s)),
              ),
            if (_active)
              IconButton(
                icon: const Icon(Icons.clear),
                color: Colors.white,
                onPressed: _onClear,
              ),
          ],
        );
      },
    );
  }
}
