import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    this.title,
    this.color,
    this.margin = const EdgeInsets.all(4.0),
    this.padding = const EdgeInsets.all(4.0),
    this.addBanner = false,
    this.bannerMessage,
    @required this.child,
  }) : super(key: key);

  final String title;
  final Color color;
  final EdgeInsetsGeometry margin, padding;
  final bool addBanner;
  final String bannerMessage;
  final Widget child;

  Widget _buildTitle(BuildContext context, String text) {
    final titleStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: titleStyle,
      ),
    );
  }

  Widget _wrapWithBanner(BuildContext context, Widget child) {
    assert(addBanner && bannerMessage != null,
        'Banner message can\'t be null when addBanner is set to true');
    return Banner(
      message: bannerMessage,
      location: BannerLocation.topEnd,
      color: Colors.red[900],
      textStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardContent = Padding(
      padding: padding,
      child: title != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_buildTitle(context, title), child],
            )
          : child,
    );

    return Card(
      color: color,
      margin: margin,
      child: addBanner ? _wrapWithBanner(context, cardContent) : cardContent,
    );
  }
}
