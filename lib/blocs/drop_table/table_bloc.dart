import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catcher/core/catcher.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/services/wfcd_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'table_event.dart';
import 'table_state.dart';

class TableSearchBloc extends Bloc<SearchEvent, SearchState> {
  static final _storageService = locator<LocalStorageService>();
  static final wfcd = locator<WFCD>();

  static List<Reward> _table = [];

  static Future<void> initializeTable() async {
    Map<String, dynamic> info;

    final _directory = await getApplicationDocumentsDirectory();
    final _slimTable = File('${_directory.path}/drop_table.json');

    try {
      final response = await http.get('$dropTableUrl/data/info.json');
      info = json.decode(response.body);
    } on SocketException {
      info = {
        'timestamp': _storageService.tableTimestamp.millisecondsSinceEpoch,
      };
    }

    final timestamp = DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
    final localTimestamp = _storageService.tableTimestamp;

    _table = await wfcd.getDropTable(_slimTable, timestamp, localTimestamp);
  }

  @override
  Stream<SearchState> transform(
    Stream<SearchEvent> events,
    Stream<SearchState> Function(SearchEvent event) next,
  ) {
    return super.transform(
      Observable<SearchEvent>(events)
          .distinct()
          .debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results =
              await compute(_search, SearchTable(searchTerm, _table));

          yield SearchStateSuccess(results);
        } catch (error, stackTrace) {
          Catcher.reportCheckedError(error, stackTrace);
          yield SearchStateError('something went wrong');
        }
      }
    }
  }
}

List<Reward> _search(SearchTable drops) {
  return drops.rewards
      .where((r) => r.item.toLowerCase().contains(drops.term.toLowerCase()))
      .toList();
}

class SearchTable {
  SearchTable(this.term, this.rewards);

  final String term;
  final List<Reward> rewards;
}
