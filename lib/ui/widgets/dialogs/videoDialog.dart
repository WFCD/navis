import 'package:flutter/material.dart';

import '../animations.dart';

class VideoDialog extends StatelessWidget {
  const VideoDialog({Key key, this.lore, this.url}) : super(key: key);

  final String lore;
  final String url;

  static Future<void> showVideo(
      BuildContext context, String lore, String url) async {
    showDialog(
        context: context, builder: (_) => VideoDialog(lore: lore, url: url));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Text(
              lore,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            VideoPlayer(lore: lore, url: url),
          ],
        ),
      ),
    );
  }
}
