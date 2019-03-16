import 'package:flutter/material.dart';
import '../animations.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class VideoDialog extends StatelessWidget {
  const VideoDialog({Key key, this.lore, this.url}) : super(key: key);

  final String lore;
  final String url;

  static Future<void> showVideo(
      BuildContext context, String lore, String url) async {
    showDialog(
        context: context, builder: (_) => VideoDialog(lore: lore, url: url));
  }

  Widget dialogContent(BuildContext context) {
    return Container(
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
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          VideoPlayer(lore: lore, url: url),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: dialogContent(context),
    );
  }
}
