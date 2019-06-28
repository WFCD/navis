import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/drop_table/table_bloc.dart';
import 'package:navis/screens/drops/components/search_body.dart';

class DropTableList extends StatefulWidget {
  const DropTableList({Key key}) : super(key: key);

  @override
  _DropTableListState createState() => _DropTableListState();
}

class _DropTableListState extends State<DropTableList> {
  @override
  void initState() {
    super.initState();
    TableSearchBloc.initializeTable();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => TableSearchBloc(),
      child: const SearchBody(),
    );
  }
}
