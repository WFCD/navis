import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/drop_table/table_bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/screens/drops/components/search_bar.dart';
import 'package:navis/services/drop_data_service.dart';
import 'package:navis/services/services.dart';

class DropTableList extends StatefulWidget {
  const DropTableList({Key key}) : super(key: key);

  @override
  _DropTableListState createState() => _DropTableListState();
}

class _DropTableListState extends State<DropTableList> {
  DropTableService tableService;
  TableSearchBloc tableSearch;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    tableService = locator<DropTableService>();
    tableSearch = TableSearchBloc();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    tableSearch.dispose();
    _textController.dispose();
    super.dispose();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  void dispatch(String text) => tableSearch.dispatch(TextChanged(text: text));

  void clear() {
    _textController.text = '';
    tableSearch.dispatch(TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: tableSearch,
        child: BlocBuilder(
          bloc: tableSearch,
          builder: (BuildContext context, SearchState state) {
            final childCount =
                state is SearchStateSuccess ? state.results.length : 0;

            return Stack(children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  SliverFloatingBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Theme.of(context).primaryColor,
                      floating: true,
                      snap: true,
                      title: SearchBar(textController: _textController),
                      trailing: IconButton(
                        icon: Icon(Icons.clear,
                            color: Theme.of(context).accentColor),
                        onPressed: clear,
                      )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (state is SearchStateSuccess) {
                          final item = state.results[index];
                          final place = _parseHtmlString(item.place);

                          return Tiles(
                            child: ListTile(
                              title: Text(item.item),
                              subtitle: Text('$place | ${item.chance}%'),
                            ),
                          );
                        }
                      },
                      childCount: childCount,
                    ),
                  )
                ],
              ),
              if (state is SearchStateSuccess && state.results.isEmpty)
                const Center(child: Text('No Results')),
              if (state is SearchStateLoading)
                const Center(child: CircularProgressIndicator()),
              if (state is SearchStateEmpty)
                const Center(
                    child: Text(
                        'Type what you\'re looking for into the search above above!'))
            ]);
          },
        ));
  }
}
