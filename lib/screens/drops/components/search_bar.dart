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

    return Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        color: Theme.of(context).primaryColor,
        child: TextField(
          controller: _textController,
          autocorrect: false,
          onChanged: (text) {
            tableSearch.dispatch(
              TextChanged(text: text),
            );
          },
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
                _textController.text = '';
                tableSearch.dispatch(TextChanged(text: ''));
              },
            ),
            border: InputBorder.none,
            hintText: 'Enter a search term',
          ),
        ));
  }
}
