import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/widgets/animations/countdown.dart';
import 'package:navis/widgets/widgets.dart';
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
      return await api.getDeal(widget.deal);
    });
  }

  Widget _placeholder(BuildContext context, String url) {
    final height = SizeConfig.heightMultiplier * 25;
    final width = SizeConfig.widthMultiplier * 45;

    return AspectRatio(
      aspectRatio: width / height,
      child: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorWidget(BuildContext context, String url, Object error) {
    return const NavisErrorWidget(
      title: 'Item not found by API',
      description:
          'Sorry but it seems the item hasn\'t been added to the API yet.',
      showStacktrace: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final height = SizeConfig.heightMultiplier * 30;
    final width = SizeConfig.widthMultiplier * 30;

    final primary = Theme.of(context).primaryColor;

    return FutureBuilder<ItemObject>(
      future: _getItem(),
      builder: (BuildContext context, AsyncSnapshot<ItemObject> snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final item = snapshot.data;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LimitedBox(
                    maxHeight: height,
                    maxWidth: width,
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      placeholder: _placeholder,
                      errorWidget: _errorWidget,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: DealDetails(
                      itemName: item.name,
                      itemDescription: parseHtmlString(item.description),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  StaticBox.text(
                      text: '${widget.deal.discount}% Discount',
                      color: primary),
                  // TODO(Orn): should probably put a plat icon here instead
                  StaticBox.text(
                      text: '${widget.deal.salePrice}\p', color: primary),
                  StaticBox.text(
                      text:
                          '${widget.deal.total - widget.deal.sold} / ${widget.deal.total} remaining',
                      color: primary),
                  CountdownBox(expiry: widget.deal.expiry),
                ],
              ),
              if (item.wikiaUrl != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: const Text('Wikia Page'),
                    onPressed: () => launchLink(context, item?.wikiaUrl),
                  ),
                ),
            ]);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DealDetails extends StatelessWidget {
  const DealDetails({
    Key key,
    this.itemName,
    this.itemDescription,
    this.wikiaUrl,
    this.itemInfo,
  }) : super(key: key);

  final String itemName, itemDescription, wikiaUrl;
  final Widget itemInfo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          itemName,
          style: textTheme.subhead
              .copyWith(fontSize: SizeConfig.textMultiplier * 2.5),
        ),
        const SizedBox(height: 4.0),
        Text(
          itemDescription,
          style: textTheme.caption
              .copyWith(fontSize: SizeConfig.textMultiplier * 2),
        ),
        itemInfo ?? Container()
      ],
    );
  }
}
