import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/search/bloc/search_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class ItemsSearchBar extends StatefulWidget {
  const ItemsSearchBar({super.key, this.hintText});

  final String? hintText;

  @override
  State<ItemsSearchBar> createState() => _ItemsSearchBarState();
}

class _ItemsSearchBarState extends State<ItemsSearchBar> {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  Future<Iterable<Widget>> _suggestionsBuilder(BuildContext context, SearchController controller) async {
    final bloc = context.read<SearchBloc>();
    final state = bloc.state;

    if (state case SearchSuccessful(:final results)) {
      return results.map((i) => ItemTile(item: i));
    }

    return <Widget>[];
  }

  void _onSubmitted(BuildContext context, String query) {
    context.read<SearchBloc>().add(ItemsSearchTextChanged(query));
    _controller.closeView(_controller.text);

    if (!Navigator.of(context).canPop()) {
      CodexPageRoute(query).push<void>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        return NavisSearchBar(
          focusNode: _focusNode,
          controller: _controller,
          suggestionsBuilder: _suggestionsBuilder,
          onChange: _onSubmitted,
          onSubmit: _onSubmitted,
          hintText: widget.hintText ?? context.l10n.codexHint,
          backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.secondaryContainer),
          leading: Navigator.of(context).canPop()
              ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))
              : const Icon(Icons.search),
          trailing: Navigator.of(context).canPop()
              ? [if (state is SearchSuccessful) const _ItemTypePopupMenuButton()]
              : null,
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
