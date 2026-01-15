import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/codex/utils/debouncer.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';

class CodexSearchBar extends StatefulWidget {
  const CodexSearchBar({super.key, this.focusNode, this.controller, this.hintText});

  final FocusNode? focusNode;
  final SearchController? controller;
  final String? hintText;

  @override
  State<CodexSearchBar> createState() => _CodexSearchBarState();
}

class _CodexSearchBarState extends State<CodexSearchBar> {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  Iterable<CodexItem> _lastOptions = <CodexItem>[];

  late final Debounceable<Iterable<CodexItem>?, String> _debounceSearch;

  Future<List<CodexItem>?> _search(String query) async {
    final api = RepositoryProvider.of<Codex>(context);

    try {
      final options = await api.search(query);
      return options..prioritizeResults();
    } on Exception {
      return null;
    }
  }

  Future<Iterable<Widget>> _suggestionsBuilder(BuildContext context, SearchController controller) async {
    final query = controller.text;
    if (query.isEmpty) return <Widget>[];

    final options = (await _debounceSearch(query))?.toList();

    Widget container(CodexItem item) {
      return EntryViewOpenContainer(
        uniqueName: item.uniqueName,
        name: item.name,
        description: item.description,
        imageName: item.imageName,
        type: item.type,
        vaulted: item.vaulted,
        wikiaUrl: item.wikiaUrl,
        wikiaThumbnail: item.wikiaThumbnail,
        builder: (_, onTap) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CodexResult(item: item, showDescription: item.description != null, onTap: onTap),
          );
        },
      );
    }

    if (options == null) return _lastOptions.map(container);

    _lastOptions = options;
    return _lastOptions.map(container);
  }

  void _onSubmitted(String query) {
    BlocProvider.of<SearchBloc>(context).add(CodexTextChanged(query));
    _controller.closeView(_controller.text);

    if (!Navigator.of(context).canPop()) {
      CodexPageRoute(query).push<void>(context);
    }
  }

  List<PopupMenuEntry<WarframeItemCategory>> _itemBuilder() {
    return WarframeItemCategory.values.map((e) {
      return PopupMenuItem<WarframeItemCategory>(value: e, child: Text(toBeginningOfSentenceCase(e.name, 'en')!));
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
            viewOnSubmitted: _onSubmitted,
            builder: (context, controller) {
              return SearchBar(
                focusNode: _focusNode,
                controller: controller,
                onTap: _controller.openView,
                onTapOutside: (_) => _focusNode.unfocus(),
                hintText: widget.hintText ?? l10n.codexHint,
                backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.secondaryContainer),
                leading: Navigator.of(context).canPop()
                    ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))
                    : const Icon(Icons.search),
                trailing: Navigator.of(context).canPop()
                    ? [
                        if (state is CodexSearchSuccess)
                          PopupMenuButton<WarframeItemCategory>(
                            icon: const Icon(Icons.filter_list),
                            itemBuilder: (_) => _itemBuilder(),
                            onSelected: (s) => BlocProvider.of<SearchBloc>(context).add(CodexResultsFiltered(s)),
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
    // Let the parent widget dispose of resources if they are provided
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }
}
