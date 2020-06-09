import 'package:flutter/material.dart';
import 'package:navis/utils/helper_utils.dart';

import 'item_image.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    Key key,
    this.description,
    this.imageName,
    this.wikiaUrl,
  }) : super(key: key);

  final String description, imageName, wikiaUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ItemImage(imageName: imageName, height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '" $description "',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontStyle: FontStyle.italic),
              ),
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
      ),
    );
  }
}
