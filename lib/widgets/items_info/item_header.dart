import 'package:flutter/material.dart';
import 'package:navis/utils/helper_utils.dart';

import 'item_image.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    Key key,
    this.name,
    this.description,
    this.imageName,
    this.wikiaUrl,
  }) : super(key: key);

  final String name, description, imageName, wikiaUrl;

  @override
  Widget build(BuildContext context) {
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(name, style: Theme.of(context).textTheme.title),
        const SizedBox(height: 8.0),
        Text(
          '" $description "',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontStyle: FontStyle.italic),
        )
      ],
    );

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints.expand(height: 100),
            margin: const EdgeInsets.only(bottom: 144.0),
            color: Theme.of(context).cardColor,
          ),
        ),
        Positioned(
          top: 16.0,
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ItemImage(imageName: imageName, height: 180),
                  const SizedBox(width: 16.0),
                  Expanded(child: info),
                ],
              ),
              if (wikiaUrl != null)
                FlatButton(
                  child: const Text('See Wikia'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () => launchLink(wikiaUrl),
                )
            ],
          ),
        )
      ],
    );
  }
}
