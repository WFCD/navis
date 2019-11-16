import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/search_utils.dart';
import 'package:navis/utils/utils.dart';

import 'search_results_sort.dart';

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

  List<PopupMenuItem<SearchTypes>> _buildItems(BuildContext context) {
    return SearchTypes.values.map((v) {
      final option = toBeginningOfSentenceCase(v.toString().split('.').last);

      return PopupMenuItem<SearchTypes>(child: Text(option), value: v);
    }).toList();
  }

  void _onSelected(Box box, SearchTypes previous, SearchTypes next) {
    if (previous != next) {
      box.put('searchType', searchTypeToString(next));

      BlocProvider.of<SearchBloc>(context)
          .add(TextChanged(_textEditingController.text, type: next));
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
          child: WatchBoxBuilder(
            box: RepositoryProvider.of<Repository>(context).persistent.hiveBox,
            watchKeys: const ['searchType'],
            builder: (BuildContext context, Box box) {
              final type = stringToSearchType(box.get('searchType'));

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_active)
                    IconButton(icon: Icon(Icons.clear), onPressed: _onClear),
                  if (type == SearchTypes.drops) const SearchResultsSort(),
                  PopupMenuButton<SearchTypes>(
                    initialValue: type,
                    itemBuilder: _buildItems,
                    onSelected: (t) => _onSelected(box, type, t),
                  )
                ],
              );
            },
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
