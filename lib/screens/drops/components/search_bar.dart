import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableSearch = BlocProvider.of<TableSearchBloc>(context);

    void dispatch(String text) => tableSearch.dispatch(TextChanged(text: text));

    return SliverPadding(
      padding: const EdgeInsets.only(top: 8.0),
      sliver: SliverFloatingBar(
          elevation: 8.0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          floating: true,
          snap: true,
          title: TextField(
            controller: _textEditingController,
            autocorrect: false,
            onChanged: dispatch,
            onSubmitted: dispatch,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search here...',
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.clear, color: Theme.of(context).accentColor),
            onPressed: () {
              _textEditingController.text = '';
              BlocProvider.of<TableSearchBloc>(context)
                  .dispatch(TextChanged(text: ''));
            },
          )),
    );
  }
}
