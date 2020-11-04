import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class Trader extends StatelessWidget {
  const Trader({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final emptyBox = Container();
    final title = Theme.of(context).textTheme.subtitle1;
    final localizations = NavisLocalizations.of(context);

    return Tiles(
        title: localizations.baroTitle,
        child: BlocBuilder<WorldstateBloc, WorldStates>(
          buildWhen: (WorldStates previous, WorldStates current) {
            final previousTrader = previous.worldstate?.voidTrader;
            final currentTrader = previous.worldstate?.voidTrader;

            return previousTrader != currentTrader ?? false;
          },
          builder: (BuildContext context, WorldStates state) {
            final trader = state.worldstate?.voidTrader;

            return Column(children: <Widget>[
              RowItem(
                  text: Text(
                    trader.active
                        ? localizations.baroLeaving
                        : localizations.baroArriving,
                    style: title,
                  ),
                  child: CountdownBox(
                      expiry:
                          trader.active ? trader.expiry : trader.activation)),
              const SizedBox(height: 4.0),
              trader.active
                  ? RowItem(
                      text: Text(localizations.baroLocation, style: title),
                      child: StaticBox.text(
                        text: '${trader.location}',
                        color: Colors.blueAccent[400],
                      ))
                  : emptyBox,
              const SizedBox(height: 4.0),
              RowItem(
                text: Text(
                  trader.active
                      ? localizations.baroArrivesOn
                      : localizations.baroArrivesOn,
                  style: title,
                ),
                child: trader.active
                    ? DateView(expiry: trader.expiry)
                    : DateView(expiry: trader.activation),
              ),
              trader.active
                  ? _InventoryButton(inventory: trader.inventory)
                  : emptyBox,
            ]);
          },
        ));
  }
}

class _InventoryButton extends StatelessWidget {
  const _InventoryButton({Key key, @required this.inventory}) : super(key: key);

  final List<InventoryItem> inventory;

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Material(
        elevation: 2.0,
        color: Colors.blueAccent[400],
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed('inventory', arguments: inventory),
          child: Container(
              width: 500.0,
              height: 30.0,
              alignment: Alignment.center,
              child: Text(
                localizations.baroInventory,
                style: const TextStyle(fontSize: 17.0, color: Colors.white),
              )),
        ),
      ),
    );
  }
}
