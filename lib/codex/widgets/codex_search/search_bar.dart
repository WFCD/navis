import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/codex/utils/debouncer.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class CodexSearchBar extends StatefulWidget {
  const CodexSearchBar({
    super.key,
    this.focusNode,
    this.controller,
    this.hintText,
  });

  final FocusNode? focusNode;
  final SearchController? controller;
  final String? hintText;

  @override
  State<CodexSearchBar> createState() => _CodexSearchBarState();
}

class _CodexSearchBarState extends State<CodexSearchBar> {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  String? _currentQuery;
  Iterable<Widget> _lastOptions = <Widget>[];

  late final Debounceable<List<MinimalItem>?, String> _debounceSearch;

  Future<List<MinimalItem>?> _search(String query) async {
    _currentQuery = query;

    final api = RepositoryProvider.of<WarframestatRepository>(context);
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
    if (query.isEmpty) return <Widget>[];

    final options = (await _debounceSearch(query))?.toList();
    if (options == null) return _lastOptions;

    return _lastOptions = options
        .where((e) => e.name.toLowerCase() == controller.text.toLowerCase())
        .map((e) {
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
    _controller.closeView(_controller.text);

    if (!Navigator.of(context).canPop()) {
      CodexPageRoute(query).push<void>(context);
    }
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
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? SearchController();
    _debounceSearch = debounce(_search);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SearchAnchor(
            searchController: _controller,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            suggestionsBuilder: _suggestionsBuilder,
            viewLeading: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                _controller.closeView(null);

                if (!Navigator.canPop(context)) {
                  _controller.clear();
                  _focusNode.unfocus();
                }
              },
            ),
            viewOnChanged: _search,
            viewOnSubmitted: _onSubmitted,
            builder: (context, controller) {
              return SearchBar(
                focusNode: _focusNode,
                controller: controller,
                onChanged: _search,
                onSubmitted: _onSubmitted,
                onTap: _controller.openView,
                onTapOutside: (_) => _focusNode.unfocus(),
                hintText: widget.hintText ?? l10n.codexHint,
                leading: Navigator.of(context).canPop()
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                trailing: Navigator.of(context).canPop()
                    ? [
                        if (state is CodexSuccessfulSearch)
                          PopupMenuButton<WarframeItemCategory>(
                            icon: const Icon(Icons.filter_list),
                            itemBuilder: (_) => _itemBuilder(),
                            onSelected: (s) =>
                                BlocProvider.of<SearchBloc>(context)
                                    .add(FilterResults(s)),
                          ),
                      ]
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // let the parent widget dispose of resources
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }
}
