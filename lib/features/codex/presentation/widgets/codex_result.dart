import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/widgets/custom_card.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_api_models/entities.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({Key key, this.item}) : super(key: key);

  final BaseItem item;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizeInfo) {
        return CustomCard(
          child: Container(
            height: getValueForScreenType(context: context, mobile: 150),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: ItemContent(
                        name: item.name,
                        description: item.description ?? '',
                        imageUrl: item.imageUrl,
                        wikiaUrl: item.wikiaUrl,
                      ),
                    ),
                    // const Spacer(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CircleAvatar(
                          radius: getValueForScreenType(
                            context: context,
                            mobile: 25,
                          ),
                          backgroundColor: Theme.of(context).cardTheme.color,
                          backgroundImage:
                              CachedNetworkImageProvider(item.imageUrl),
                        ),
                      ),
                    )
                  ],
                ),
                if (item.wikiaUrl != null)
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: const Text('See wikia'),
                      )
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    Key key,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    this.wikiaUrl,
  })  : assert(name != null),
        assert(description != null),
        assert(imageUrl != null),
        super(key: key);

  final String name, description, imageUrl, wikiaUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizeInfo) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                name,
                style: textTheme.subtitle1,
              ),
              const SizedBox(height: 12),
              Container(
                child: Text(
                  description,
                  style: textTheme.caption,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
