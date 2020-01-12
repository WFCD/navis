import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
    BlocProvider.of<SearchBloc>(context).add(TextChanged(text));
  }

  void _onClear() {
    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    BlocProvider.of<SearchBloc>(context).add(const TextChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2C2C2C)
        : Theme.of(context).cardColor;

    return SliverPadding(
      padding: const EdgeInsets.only(top: 8.0),
      sliver: SliverFloatingBar(
        elevation: 8.0,
        automaticallyImplyLeading: false,
        floating: true,
        snap: true,
        backgroundColor: backgroundColor,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_active)
                IconButton(icon: const Icon(Icons.clear), onPressed: _onClear),
            ],
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
