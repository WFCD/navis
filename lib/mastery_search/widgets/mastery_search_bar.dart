import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/mastery_search/bloc/mastery_search_bloc.dart';
import 'package:navis/mastery_search/view/view.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';

class MasterySearchBar extends StatefulWidget {
  const MasterySearchBar({super.key, this.hintText});

  final String? hintText;

  @override
  State<MasterySearchBar> createState() => _MasterySearchBarState();
}

class _MasterySearchBarState extends State<MasterySearchBar> {
  late final FocusNode _focusNode = FocusNode(debugLabel: 'mastery_search+_bar');
  late final SearchController _controller = SearchController();

  void _onSubmitted(BuildContext context, String query) {
    context.read<MasterySearchBloc>().add(MasterySearchTextChanged(query));
    _controller.closeView(_controller.text);

    if (!Navigator.of(context).canPop()) {
      CodexPageRoute(query).push<void>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavisSearchBar(
      focusNode: _focusNode,
      controller: _controller,
      suggestionsBuilder: (_, _) => [],
      onChange: (query) => BlocProvider.of<MasterySearchBloc>(context).add(MasterySearchTextChanged(query)),
      onSubmit: _onSubmitted,
      hintText: widget.hintText,
      backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.secondaryContainer),
      leading: Navigator.of(context).canPop()
          ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))
          : const Icon(Icons.search),
      viewBuilder: (_) =>
          BlocProvider.value(value: BlocProvider.of<MasterySearchBloc>(context), child: const MasterySearchView()),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
