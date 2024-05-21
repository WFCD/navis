import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CommonModPainter extends ModPainter {
  const CommonModPainter({
    required super.mod,
    required super.rank,
    required super.assets,
  });

  @override
  double get effectsY => 375;

  @override
  double get ranksY => 440;
}

class LegendaryModPainter extends ModPainter {
  const LegendaryModPainter({
    required super.mod,
    required super.rank,
    required super.assets,
  });

  @override
  double get effectsY => 380;

  @override
  double get ranksY => 444;
}

abstract class ModPainter extends CustomPainter {
  const ModPainter({
    required this.mod,
    required this.rank,
    required this.assets,
  });

  final Mod mod;
  final int rank;
  final ModAssets assets;

  double get effectsY;
  double get ranksY;

  void drawEffects(Canvas canvas) {
    final paint = Paint();
    final frame = assets.frame;

    canvas.drawImage(frame.cornerLights, Offset(195, effectsY), paint);

    final cornerLightsLeft = Offset(-5, effectsY) & const Size(64, 64);
    paintImage(
      canvas: canvas,
      rect: cornerLightsLeft,
      image: frame.cornerLights,
      flipHorizontally: true,
    );
  }

  void drawRanks(Canvas canvas, Size size) {
    var rankSlotStart = 50.0;
    final maxRank = mod.fusionLimit;
    if (maxRank == null) return;

    if (maxRank <= 3) rankSlotStart = size.width / 3.6;
    if (maxRank <= 5) rankSlotStart += 40;

    for (var i = 0; i < maxRank; i++) {
      final slot = i < rank ? assets.rankSlotActive : assets.rankSlotEmpty;
      canvas.drawImage(slot, Offset(rankSlotStart, ranksY), Paint());
      rankSlotStart += 15.0;
    }
  }

  Rarity? get _rarity => mod.rarity;
  int? get drain => mod.baseDrain != null ? mod.baseDrain! + rank : null;

  void paintBacker(Canvas canvas) {
    final surface = assets.surface;
    if (drain != null) {
      canvas.drawImage(surface.backer, const Offset(205, 95), Paint());

      if (drain! < 0) {
        TextPainter(
          text: TextSpan(
            text: '^${drain!.abs()}',
            style: TextStyle(color: _rarity?.toColor()),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(canvas, const Offset(218, 102));
      } else {
        TextPainter(
          text: TextSpan(
            text: '${drain!.abs()}',
            style: TextStyle(color: _rarity?.toColor()),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )
          ..layout()
          ..paint(canvas, const Offset(218, 101));
      }
    }

    final polarity = assets.polarity;
    const polarityPosition = Offset(228, 100);
    if (polarity != null && drain != null) {
      if (drain! < 0) {
        final rect = polarityPosition & const Size(17, 17);
        paintPolarity(canvas, rect);
      } else {
        final rect = polarityPosition & const Size(18, 18);
        paintPolarity(canvas, rect);
      }
    }
  }

  void paintCompt(Canvas canvas, Size size) {
    canvas.drawImage(assets.surface.lowerTab, const Offset(23, 386), Paint());

    final painter = TextPainter(
      text: TextSpan(
        text: mod.compatName?.trim() ?? '',
        style: TextStyle(color: _rarity?.toColor()),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    painter.paint(canvas, Offset((size.width - painter.width) * .5, 390));
  }

  void paintDescription(Canvas canvas, Size size) {
    final description = formatDescription(mod.description, mod.levelStats);

    final span = TextSpan(
      text: description,
      style: TextStyle(color: mod.rarity?.toColor()),
    );

    final painter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 200);

    final offset = Offset(
      (size.width - painter.width) * 0.5,
      // I don't know how this works or how I came up with it but it works.
      // If anyone finds this and can explain it, please tell me
      ((size.height - painter.height) * .60) + (painter.height / 3),
    );

    painter.paint(canvas, offset);
  }

  void paintPolarity(Canvas canvas, Rect rect) {
    paintImage(
      canvas: canvas,
      rect: rect,
      // Assuming you check before calling this function
      image: assets.polarity!,
      colorFilter: ColorFilter.mode(
        _rarity?.toColor() ?? Colors.white,
        BlendMode.srcIn,
      ),
    );
  }

  void paintBackground(Canvas canvas) {
    final paint = Paint();
    final surface = assets.surface;
    canvas.drawImage(surface.background, Offset.zero, paint);

    final dstRec = const Offset(6, 86) & const Size(244, 180);
    final thumbnailRec = Offset.zero & const Size(250, 250);
    canvas.drawImageRect(assets.thumbnail, thumbnailRec, dstRec, paint);
  }

  void paintFrame(Canvas canvas) {
    final paint = Paint();
    final frame = assets.frame;
    canvas
      ..drawImage(frame.top, const Offset(0, 70), paint)
      ..drawImage(frame.bottom, const Offset(0, 340), paint)
      ..drawImage(frame.sideLights, const Offset(240, 120), paint);

    final sideLightLeft = const Offset(0, 120) & const Size(16, 256);
    paintImage(
      canvas: canvas,
      rect: sideLightLeft,
      image: frame.sideLights,
      flipHorizontally: true,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBackground(canvas);
    paintDescription(canvas, size);
    paintBacker(canvas);
    paintFrame(canvas);
    paintCompt(canvas, size);
    drawEffects(canvas);
    drawRanks(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
