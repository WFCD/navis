import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key, @required this.textController}) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final tableSearch = BlocProvider.of<TableSearchBloc>(context);

    void dispatch(String text) => tableSearch.dispatch(TextChanged(text: text));

    return TextField(
      controller: textController,
      autocorrect: false,
      onChanged: dispatch,
      onSubmitted: dispatch,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search here...',
      ),
    );
  }
}
