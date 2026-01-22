import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/utils/debouncer.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile/utils/mastery_utils.dart';

class MasteryItemSearchBar extends StatefulWidget {
  const MasteryItemSearchBar({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  State<MasteryItemSearchBar> createState() => _MasteryItemSearchBarState();
}

class _MasteryItemSearchBarState extends State<MasteryItemSearchBar> {
  late final Debounceable<List<CodexItem>?, String> _debounceSearch;
  late final SearchController _controller;

  Iterable<CodexItem> _lastOptions = [];

  @override
  void initState() {
    super.initState();

    _controller = SearchController();
    _debounceSearch = debounce(_search);
  }

  List<CodexItem> _search(String query) {
    final state = BlocProvider.of<MasteryProgressCubit>(context).state;
    final items = switch (state) {
      MasteryProgressSuccess(items: final items) => items,
      _ => <CodexItem>[],
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
    return BlocSelector<MasteryProgressCubit, MasteryProgressState, List<CodexItem>>(
      selector: (state) => switch (state) {
        MasteryProgressSuccess(items: final items) => items,
        _ => [],
      },
      builder: (context, items) {
        final completed = items.where((i) => masteryRank(i, i.xpInfo.value?.xp ?? 0) == (i.maxLevelCap ?? 30));

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
