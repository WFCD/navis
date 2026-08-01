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
    this.viewBuilder,
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
  final ViewBuilder? viewBuilder;
  final ValueChanged<String>? onChange;
  final ItemsValueChanged onSubmit;

  void _onClose(BuildContext context) {
    controller?.clear();
    focusNode?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final viewLeading = Navigator.canPop(context)
        ? IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () => controller?.closeView(null),
          )
        : null;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchAnchor(
        searchController: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        suggestionsBuilder: suggestionsBuilder,
        viewPadding: EdgeInsets.zero,
        viewBuilder: viewBuilder != null
            ? (s) => MediaQuery.removePadding(context: context, removeTop: true, child: viewBuilder!.call(s))
            : null,
        viewLeading: viewLeading,
        viewOnSubmitted: (query) => onSubmit(context, query),
        viewOnChanged: onChange,
        viewOnClose: () => _onClose(context),
        builder: (context, controller) {
          return SearchBar(
            focusNode: focusNode,
            leading: leading,
            controller: controller,
            onTap: this.controller?.openView,
            onTapOutside: (_) => focusNode?.unfocus(),
            hintText: hintText,
            backgroundColor: backgroundColor,
          );
        },
      ),
    );
  }
}
