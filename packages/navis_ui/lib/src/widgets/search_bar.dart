import 'package:flutter/material.dart';

typedef ItemsValueChanged = void Function(BuildContext context, String query);

class NavisSearchBar extends StatelessWidget {
  const NavisSearchBar({
    super.key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.leading,
    this.trailing,
    this.backgroundColor,
    required this.suggestionsBuilder,
    required this.onChange,
    required this.onSubmit,
  });

  final FocusNode? focusNode;
  final SearchController? controller;
  final Widget? leading;
  final Iterable<Widget>? trailing;
  final WidgetStateProperty<Color?>? backgroundColor;
  final String? hintText;
  final SuggestionsBuilder suggestionsBuilder;
  final ItemsValueChanged onChange;
  final ItemsValueChanged onSubmit;

  void _onPressed(BuildContext context) {
    controller?.closeView(null);

    if (!Navigator.canPop(context)) {
      controller?.clear();
      focusNode?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchAnchor(
        searchController: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        suggestionsBuilder: suggestionsBuilder,
        viewLeading:
            leading ??
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => _onPressed(context),
            ),
        viewOnSubmitted: (query) => onSubmit(context, query),
        builder: (context, controller) {
          return SearchBar(
            focusNode: focusNode,
            controller: controller,
            onTap: this.controller?.openView,
            onTapOutside: (_) => focusNode?.unfocus(),
            onChanged: (query) => onChange(context, query),
            hintText: hintText,
            backgroundColor: backgroundColor,
            leading: leading,
            trailing: trailing,
          );
        },
      ),
    );
  }
}
