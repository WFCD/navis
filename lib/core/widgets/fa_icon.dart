import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// So I borrowed this from the Font_Awsome package, becauase of the docs you
// see below as I didn't want to add the whole package for one or two icons
// the icons that will mainly use this are one like simiras

/// Creates an Icon Widget that works for non-material Icons, such as the
/// Font Awesome Icons.
///
/// The default `Icon` Widget from the Material package assumes all Icons are
/// square in size and wraps all Icons in a square SizedBox Widget. Icons from
/// the FontAwesome package are often wider than they are tall, which causes
/// alignment and cutoff issues.
///
/// This Widget does not wrap the icons in a fixed square box, which allows the
/// icons to render based on their size.
class FaIcon extends StatelessWidget {
  /// Creates an icon.
  ///
  /// The [size] and [color] default to the value given
  /// by the current [IconTheme].
  const FaIcon(
    this.icon, {
    Key key,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : assert(icon != null),
        super(key: key);

  /// The icon to display. The available icons are described in
  final IconData icon;

  /// The font size of the icon.
  ///
  /// Defaults to the current [IconTheme] size, if any. If there is no
  /// [IconTheme], or it does not specify an explicit size, then it defaults to
  /// 24.0.
  final double size;

  /// The color to use when drawing the icon.
  ///
  /// Defaults to the current [IconTheme] color, if any.
  ///
  /// The given color will be adjusted by the opacity of the current
  /// [IconTheme], if any.
  final Color color;

  /// Semantic label for the icon.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  final String semanticLabel;

  /// The text direction to use for rendering the icon.
  ///
  /// If this is null, the ambient [Directionality] is used instead.
  ///
  /// Some icons follow the reading direction. For example, "back" buttons point
  /// left in left-to-right environments and right in right-to-left
  /// environments. Such icons have their [IconData.matchTextDirection] field
  /// set to true, and the [FaIcon] widget uses the [textDirection] to determine
  /// the orientation in which to draw the icon.
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is false, but for consistency a text direction value must always be
  /// specified, either directly using this property or using [Directionality].
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final textDirection = this.textDirection ?? Directionality.of(context);

    final iconTheme = IconTheme.of(context);

    final iconSize = size ?? iconTheme.size;

    if (icon == null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(width: iconSize, height: iconSize),
      );
    }

    final iconOpacity = iconTheme.opacity;

    var iconColor = color ?? iconTheme.color;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible, // Never clip.
      textDirection:
          textDirection, // Since we already fetched it for the assert...
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
    );

    if (icon.matchTextDirection) {
      switch (textDirection) {
        case TextDirection.rtl:
          iconWidget = Transform(
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            alignment: Alignment.center,
            transformHitTests: false,
            child: iconWidget,
          );
          break;
        case TextDirection.ltr:
          break;
      }
    }

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: iconWidget,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IconDataProperty('icon', icon, ifNull: '<empty>', showName: false))
      ..add(DoubleProperty('size', size, defaultValue: null))
      ..add(ColorProperty('color', color, defaultValue: null));
  }
}
