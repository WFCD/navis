import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/codex/utils/debouncer.dart';
import 'package:navis/profile/cubit/arsenal_cubit.dart';
import 'package:navis/profile/utils/extensions.dart';
import 'package:navis/profile/widgets/widgets.dart';

class MasteryItemSearchBar extends StatefulWidget {
  const MasteryItemSearchBar({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  State<MasteryItemSearchBar> createState() => _MasteryItemSearchBarState();
}

class _MasteryItemSearchBarState extends State<MasteryItemSearchBar> {
  late final Debounceable<List<InventoryItemData>?, String> _debounceSearch;
  late final SearchController _controller;

  Iterable<InventoryItemData> _lastOptions = [];

  @override
  void initState() {
    super.initState();

    _controller = SearchController();
    _debounceSearch = debounce(_search);
  }

  List<InventoryItemData> _search(String query) {
    final state = BlocProvider.of<ArsenalCubit>(context).state;
    final items = switch (state) {
      ArsenalSuccess() => state.items,
      _ => <InventoryItemData>[],
    };

    return items.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Future<Iterable<Widget>> _suggestionsBuilder(BuildContext context, SearchController controller) async {
    final query = controller.text;
    if (query.isEmpty) return <Widget>[];

    final options = await _debounceSearch(query);
    if (options == null) {
      return _lastOptions.map((i) => ArsenalItemWidget(item: i));
    }

    _lastOptions = options;
    return _lastOptions.map((i) => ArsenalItemWidget(item: i));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ArsenalCubit, ArsenalState, List<InventoryItemData>>(
      selector:
          (state) => switch (state) {
            ArsenalSuccess(items: final items) => items,
            _ => [],
          },
      builder: (context, items) {
        final completed = items.where((i) => i.rank == i.maxRank);

        return SearchAnchor.bar(
          barLeading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: widget.onPressed),
          barBackgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondaryContainer),
          barHintText: 'Mastered ${completed.length} out of ${items.length}',
          suggestionsBuilder: _suggestionsBuilder,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
