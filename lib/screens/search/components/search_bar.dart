import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/search/components/search_results_sort.dart';
import 'package:simple_animations/simple_animations.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with AnimationControllerMixin {
  final _iconKey = GlobalKey();

  Animation<double> _progress;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _progress = Tween(begin: 0.0, end: 1.0).animate(controller);
    _textEditingController = TextEditingController();

    _textEditingController.addListener(_textListener);

    super.initState();
  }

  void _textListener() {
    const duration = Duration(milliseconds: 250);

    if (_textEditingController.text.isNotEmpty &&
        controller.status != AnimationStatus.completed) {
      controller.addTask(FromToTask(duration: duration, to: 1.0));
    }

    if (_textEditingController.text.isEmpty) {
      controller.addTask(FromToTask(duration: duration, to: 0.0));
    }
  }

  RelativeRect _getIconPosition() {
    final RenderBox icon = _iconKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        icon.localToGlobal(icon.size.center(Offset.zero), ancestor: overlay),
        icon.localToGlobal(icon.size.center(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return position;
  }

  Future<void> _onPressed(SearchTypes searchType) async {
    if (controller.isCompleted) {
      _textEditingController.clear();
      FocusScope.of(context).unfocus();

      BlocProvider.of<SearchBloc>(context).dispatch(TextChanged(''));
    } else if (!controller.isCompleted) {
      final SearchTypes selected = await showMenu<SearchTypes>(
        context: context,
        initialValue: searchType,
        position: _getIconPosition(),
        items: [
          PopupMenuItem<SearchTypes>(
            child: const Text('Search Drop Table'),
            value: SearchTypes.drops,
          ),
          PopupMenuItem<SearchTypes>(
            child: const Text('Seatch Warframe Items'),
            value: SearchTypes.items,
          )
        ],
      );

      if (selected != null && searchType != selected) {
        BlocProvider.of<SearchBloc>(context)
            .dispatch(SwitchSearchType(selected));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    void dispatch(String text) => searchBloc.dispatch(TextChanged(text));

    return SliverPadding(
      padding: const EdgeInsets.only(top: 8.0),
      sliver: SliverFloatingBar(
        elevation: 8.0,
        automaticallyImplyLeading: false,
        floating: true,
        snap: true,
        backgroundColor: Theme.of(context).cardColor,
        title: TextField(
          controller: _textEditingController,
          autocorrect: false,
          onChanged: dispatch,
          onSubmitted: dispatch,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search here...',
          ),
        ),
        trailing: LimitedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (searchBloc.searchType == SearchTypes.drops)
                SearchResultsSort(),
              IconButton(
                key: _iconKey,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _progress,
                ),
                onPressed: () =>
                    _onPressed(BlocProvider.of<SearchBloc>(context).searchType),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController?.removeListener(_textListener);
    _textEditingController?.dispose();
    super.dispose();
  }
}
