import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/drop_table/table_bloc.dart';
import 'package:navis/screens/drops/components/search_bar.dart';
import 'package:navis/screens/drops/components/search_body.dart';
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

  @override
  void initState() {
    super.initState();

    tableService = locator<DropTableService>();
    tableSearch = TableSearchBloc();
  }

  @override
  void dispose() {
    tableSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: tableSearch,
      child: Column(children: const <Widget>[SearchBar(), SearchBody()]),
    );
  }
}
