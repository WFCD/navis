import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants/sizedbox_spacer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../../utils/faction_utils.dart';
import '../../bloc/solsystem/solsystem_bloc.dart';

// For now I've opted to not add unknown construction progress
// because well it's unknown and I've never actually seen it change
// will add it when it actually changes
class ConstructionProgressCard extends StatelessWidget {
  const ConstructionProgressCard({Key? key}) : super(key: key);

  Widget _paintProgress(Progress progress, TextStyle? style) {
    return SizedBox.fromSize(
      size: const Size(70, 70),
      child: CustomPaint(
        foregroundPainter: ProgressPainter(
          completeColor: progress.color,
          completePercent: progress.percentage,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text('${progress.percentage.toInt()}%', style: style),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = NavisLocalizations.of(context)!;

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<SolsystemBloc, SolsystemState>(
          buildWhen: (p, n) {
            if (p is SolState && n is SolState) {
              return p.worldstate.constructionProgress !=
                  n.worldstate.constructionProgress;
            }
            return false;
          },
          builder: (context, state) {
            final constructionProgress =
                (state as SolState).worldstate.constructionProgress;

            final formorian = Progress(
              name: l10n.formorianTitle,
              color: factionColor('Grineer'),
              percentage: double.parse(constructionProgress.fomorianProgress),
            );

            final razorback = Progress(
              name: l10n.razorbackTitle,
              color: factionColor('Corpus'),
              percentage: double.parse(constructionProgress.razorbackProgress),
            );

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (final progress in [formorian, razorback])
                  Column(
                    children: <Widget>[
                      _paintProgress(progress, textTheme.headline6),
                      SizedBoxSpacer.spacerHeight16,
                      Text(progress.name, style: textTheme.headline6)
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Progress {
  const Progress({
    required this.percentage,
    this.name = 'Unknown',
    this.color = Colors.white,
  }) : assert(percentage > 0.0);

  final double percentage;
  final Color color;
  final String name;
}

class ProgressPainter extends CustomPainter {
  const ProgressPainter({
    required this.completeColor,
    required this.completePercent,
  }) : assert(completePercent > 0.0);

  final Color completeColor;
  final double completePercent;

  @override
  void paint(Canvas canvas, Size size) {
    const width = 8.0;

    final line = Paint()
      ..color = Colors.white24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final arcAngle = 2 * pi * (completePercent / 100);
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas
      ..drawCircle(center, radius, line)
      ..drawArc(rect, -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return oldDelegate.completePercent != completePercent;
  }
}
