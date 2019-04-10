import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
//import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/layout.dart';
import 'package:navis/ui/widgets/animations.dart';

class Deals extends StatelessWidget {
  const Deals({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subhead;

    return Tiles(
        title: 'Darvo Deals',
        child: BlocBuilder(
          bloc: BlocProvider.of<WorldstateBloc>(context),
          builder: (_, state) {
            if (state is WorldstateLoaded) {
              final deals = state.worldState.dailyDeals;

              final header = TableRow(children: <Widget>[
                Text('Item', style: style),
                Text('Discount', style: style),
                Text('Price', style: style),
                Text('Stock', style: style),
                const SizedBox(width: 100)
              ]);

              return Container(
                  margin: const EdgeInsets.all(4),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    defaultColumnWidth: FlexColumnWidth(),
                    children: List.unmodifiable(() sync* {
                      yield header;
                      yield* deals.map((d) {
                        final remaining = d.total - d.sold;

                        return TableRow(children: <Widget>[
                          Text(d.item, style: style),
                          Text('${d.discount}%', style: style),
                          Text('${d.salePrice}', style: style),
                          Text('$remaining/${d.total}', style: style),
                          CountdownBox(expiry: d.expiry),
                        ]);
                      });
                    }()),
                  ));
            }
          },
        ));
  }
}
