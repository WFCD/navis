import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/search/bloc/search_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:warframe_common/warframe_common.dart';

class MasteryItemSearchBar extends StatefulWidget {
  const MasteryItemSearchBar({super.key, this.hintText});

  final String? hintText;

  @override
  State<MasteryItemSearchBar> createState() => _MasteryItemSearchBarState();
}

class _MasteryItemSearchBarState extends State<MasteryItemSearchBar> {
  late final FocusNode _focusNode;
  late final SearchController _controller;

  Future<Iterable<Widget>> _suggestionsBuilder(BuildContext context, SearchController controller) async {
    final search = context.read<SearchBloc>();
    final results = switch (search.state) {
      SearchSuccessful(:final results) => results,
      _ => <WarframeItem>[],
    };

    final profile = context.read<ProfileCubit>();
    final xpInfo = switch (profile.state) {
      ProfileSuccessful(:final xpInfo) => xpInfo.lookup,
      _ => <String, MasterableItem>{},
    };

    if (results.isNotEmpty && xpInfo.isNotEmpty) {
      return results.map((i) {
        final xp = xpInfo[i.uniqueName]?.level ?? 0;
        final maxLevel = i.maxLevel ?? 30;

        return ItemTile(
          item: i,
          child: LinearProgressIndicator(value: xp / maxLevel),
        );
      });
    }

    return <Widget>[];
  }

  void _onSubmitted(BuildContext context, String query) {
    context.read<SearchBloc>().add(MasteryItemSearchTextChanged(query));
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
