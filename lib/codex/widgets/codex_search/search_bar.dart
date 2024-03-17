import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/codex/utils/debouncer.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class CodexSearchBar extends StatefulWidget {
  const CodexSearchBar({super.key});

  @override
  State<CodexSearchBar> createState() => _CodexSearchBarState();
}

class _CodexSearchBarState extends State<CodexSearchBar> {
  late final SearchController _controller;

  String? _currentQuery;
  Iterable<Widget> _lastOptions = <Widget>[];

  late final Debounceable<List<MinimalItem>?, String> _debounceSearch;

  Future<List<MinimalItem>?> _search(String query) async {
    _currentQuery = query;

    final api = RepositoryProvider.of<WorldstateRepository>(context);
    final options = await api.searchItems(query);

    if (_currentQuery != query) return null;
    _currentQuery = null;

    return options;
  }

  Future<Iterable<Widget>> _suggestionsBuilder(
    BuildContext context,
    SearchController controller,
  ) async {
    final query = controller.text;
    final options = (await _debounceSearch(query))?.toList();

    if (options == null) return _lastOptions;

    return _lastOptions =
        options.where((e) => e.name.toLowerCase() == controller.text).map((e) {
      return OpenContainer(
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        closedBuilder: (_, onTap) => CodexResult(item: e, onTap: onTap),
        openBuilder: (_, __) => EntryView(item: e),
      );
    });
  }

  void _onSubmitted(String query) {
    BlocProvider.of<SearchBloc>(context).add(SearchCodex(query));
    if (_controller.isOpen) Navigator.pop(context);
  }

  List<PopupMenuEntry<WarframeItemCategory>> _itemBuilder() {
    return WarframeItemCategory.values.map((e) {
      return PopupMenuItem<WarframeItemCategory>(
        value: e,
        child: Text(toBeginningOfSentenceCase(e.name, 'en')!),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
    _debounceSearch = debounce(_search);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SearchAnchor.bar(
            searchController: _controller,
            barLeading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            barHintText: l10n.codexHint,
            onSubmitted: _onSubmitted,
            suggestionsBuilder: _suggestionsBuilder,
            barTrailing: [
              if (state is CodexSuccessfulSearch)
                PopupMenuButton<WarframeItemCategory>(
                  icon: const Icon(Icons.filter_list),
                  itemBuilder: (_) => _itemBuilder(),
                  onSelected: (s) => BlocProvider.of<SearchBloc>(context)
                      .add(FilterResults(s)),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
