import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/item_search/item_search.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class ItemsSearchBar extends StatefulWidget {
  const ItemsSearchBar({super.key, this.hintText, this.enableItemFilter = true, this.onChange, this.onSubmit});

  final String? hintText;
  final bool enableItemFilter;
  final ValueChanged<String>? onChange;
  final ItemsValueChanged? onSubmit;

  @override
  State<ItemsSearchBar> createState() => _ItemsSearchBarState();
}

class _ItemsSearchBarState extends State<ItemsSearchBar> {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: 'item_search_bar');
    _controller = SearchController();
  }

  void _onSubmitted(BuildContext context, String query) {
    if (widget.onSubmit != null) {
      widget.onSubmit!.call(context, query);
    } else {
      context.read<SearchBloc>().add(ItemsSearchTextChanged(query));
    }

    _controller.closeView(_controller.text);

    if (!Navigator.of(context).canPop()) {
      CodexPageRoute(query).push<void>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return NavisSearchBar(
          focusNode: _focusNode,
          controller: _controller,
          suggestionsBuilder: (_, _) => [],
          onChange: widget.onChange ?? (query) => context.read<SearchBloc>().add(ItemsSearchTextChanged(query)),
          onSubmit: widget.onSubmit ?? _onSubmitted,
          hintText: widget.hintText ?? context.l10n.codexHint,
          backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.secondaryContainer),
          leading: Navigator.canPop(context)
              ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))
              : null,
          trailing: Navigator.canPop(context)
              ? [if (state is SearchSuccessful) const _ItemTypePopupMenuButton()]
              : null,
          viewBuilder: (_) =>
              BlocProvider.value(value: BlocProvider.of<SearchBloc>(context), child: const _ItemResultsView()),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class _ItemTypePopupMenuButton extends StatelessWidget {
  const _ItemTypePopupMenuButton();

  @override
  Widget build(BuildContext context) {
    final types =
        ItemType.values.map((e) => PopupMenuItem(value: e, child: Text(toBeginningOfSentenceCase(e.type)))).toList()
          ..add(PopupMenuItem(child: Text(context.l10n.allFissuresButton)));

    return PopupMenuButton<ItemType>(
      icon: const Icon(Icons.filter_list),
      itemBuilder: (_) => types,
      onSelected: (s) => BlocProvider.of<SearchBloc>(context).add(ItemResultsFiltered(s)),
    );
  }
}

class _ItemResultsView extends StatelessWidget {
  const _ItemResultsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => switch (state) {
        SearchSuccessful(:final results) when results.isNotEmpty => ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => OpenItemContainer(
            item: results[index],
            closedBuilder: (_, _) => ItemTile(item: results[index]),
          ),
        ),
        SearchSuccessful(:final results) when results.isEmpty => Center(child: Text(context.l10n.codexNoResults)),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
