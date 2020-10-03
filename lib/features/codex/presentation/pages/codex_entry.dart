import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({Key key}) : super(key: key);

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments as BaseItem;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(floating: true, snap: true),
          SliverList(
            delegate: SliverChildListDelegate(
                [BasicItemInfo(name: item.name, imageUrl: item.imageUrl)]),
          )
        ],
      ),
    );
  }
}

class BasicItemInfo extends StatelessWidget {
  const BasicItemInfo({
    Key key,
    @required this.name,
    this.description,
    @required this.imageUrl,
    this.wikiaUrl,
  })  : assert(name != null),
        assert(imageUrl != null),
        super(key: key);

  final String name, description, imageUrl, wikiaUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [CachedNetworkImage(imageUrl: imageUrl)]),
    );
  }
}
