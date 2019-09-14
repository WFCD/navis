import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/widgets/animations/countdown.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_model/worldstate_models.dart';

class DealWidget extends StatefulWidget {
  const DealWidget({Key key, this.deal}) : super(key: key);

  final DarvoDeal deal;

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget>
    with AutomaticKeepAliveClientMixin {
  final AsyncMemoizer<ItemObject> _itemFuture = AsyncMemoizer();

  Future<ItemObject> _getItem() async {
    final api = RepositoryProvider.of<Repository>(context).worldstateService;

    return _itemFuture?.runOnce(() async {
      final List<ItemObject> items = await api.search(widget.deal.item);

      return items?.firstWhere((i) => widget.deal.item == i.name) ?? '';
    });
  }

  Widget _description(String itemName, String itemDescription) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(itemName, style: textTheme.subhead),
        const SizedBox(height: 8.0),
        Text(itemDescription, style: textTheme.caption.copyWith(fontSize: 13))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: FutureBuilder<ItemObject>(
        future: _getItem(),
        builder: (BuildContext context, AsyncSnapshot<ItemObject> snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final item = snapshot.data;
          const size = Size(150, 100);

          return Container(
              child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: item.imageUrl,
                height: size.height,
                width: size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Chip(label: Text('${widget.deal.discount}% Discount')),

                  // TODO(Orn): should probably put a plat icon here instead
                  Chip(label: Text('${widget.deal.salePrice}p')),
                  Chip(
                    label: Text(
                        '${widget.deal.total - widget.deal.sold}/${widget.deal.total} remaining'),
                  ),
                  CountdownBox(expiry: widget.deal.expiry)
                ],
              ),
              const SizedBox(height: 8.0),
              Expanded(child: _description(item.name, item.description)),
              if (item.wikiaUrl?.isNotEmpty ?? false)
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Wikia Page'),
                      onPressed: () => launchLink(context, item.wikiaUrl),
                    )
                  ],
                )
            ],
          ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
