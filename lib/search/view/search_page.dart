import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/search/search.dart';
import 'package:navis/search/view/search_view.dart';

class ItemsSearchPage extends StatelessWidget {
  const ItemsSearchPage({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(context.read<ItemsRepository>())..add(ItemsSearchTextChanged(query)),
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    titleSpacing: 0,
                    floating: true,
                    scrolledUnderElevation: 0,
                    automaticallyImplyLeading: false,
                    clipBehavior: Clip.none,
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.transparent,
                    forceElevated: innerBoxIsScrolled,
                    title: ItemsSearchBar(hintText: query),
                  ),
                ),
              ];
            },
            body: const SearchView(),
          ),
        ),
      ),
    );
  }
}

