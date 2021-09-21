import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/icons.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../bloc/solsystem_bloc.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (context, state) {
          final arbitration = (state as SolState).worldstate.arbitration!;

          return ListTile(
            leading: const Icon(SyndicateGlyphs.hexis, size: 50),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (arbitration.archwingRequired)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: NavisSystemIconWidgets.archwingIcon,
                  ),
                Text(arbitration.node!),
              ],
            ),
            subtitle: Text('${arbitration.enemy} | ${arbitration.type}'),
            trailing: CountdownTimer(expiry: arbitration.expiry!),
          );
        },
      ),
    );
  }
}
