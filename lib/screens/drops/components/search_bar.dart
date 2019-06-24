import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableSearch = BlocProvider.of<TableSearchBloc>(context);

    void dispatch(String text) => tableSearch.dispatch(TextChanged(text: text));

    void clear() {
      _textController.text = '';
      tableSearch.dispatch(TextChanged(text: ''));
    }

    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: dispatch,
      onSubmitted: dispatch,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(child: Icon(Icons.clear), onTap: clear),
        border: InputBorder.none,
        hintText: 'Search here...',
      ),
    );
  }
}
