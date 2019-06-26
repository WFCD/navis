import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/drop_table/table_bloc.dart';
import 'package:navis/screens/drops/components/search_body.dart';

class DropTableList extends StatelessWidget {
  const DropTableList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) {
        final table = TableSearchBloc();
        table.initializeTable();
        return table;
      },
      child: const SearchBody(),
    );
  }
}
