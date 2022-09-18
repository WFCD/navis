import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:market_client/market_client.dart';
import 'package:navis_ui/navis_ui.dart';

class MarketSellWidget extends StatelessWidget {
  const MarketSellWidget({super.key, required this.order});

  final OrderRow order;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: _MarketSellLeading(
              avater: order.user.avatar,
              orderType: order.orderType,
              status: order.user.status,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: _MarketSellBody(
                username: order.user.ingameName,
                reputation: order.user.reputation,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 16),
            child: _MarketSellTrailing(
              quantity: order.quantity,
              price: order.platinum,
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketSellLeading extends StatelessWidget {
  const _MarketSellLeading({
    this.avater,
    required this.orderType,
    required this.status,
  });

  final String? avater;
  final OrderType orderType;
  final UserStatus status;

  static const _defaultAvater = 'user/default-avatar.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          // This is what just worked for the style.
          // ignore: no-magic-number
          radius: 22.5,
          backgroundColor: () {
            switch (status) {
              case UserStatus.online:
                return Colors.green;
              case UserStatus.ingame:
                return Colors.purple;
              case UserStatus.offline:
                return Colors.grey[600];
            }
          }(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundImage: CachedNetworkImageProvider(
              'https://warframe.market/static/assets/${avater ?? _defaultAvater}',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            () {
              switch (orderType) {
                case OrderType.sell:
                  return 'WTS';
                case OrderType.buy:
                  return 'WTB';
              }
            }(),
            style: context.theme.textTheme.caption
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _MarketSellBody extends StatelessWidget {
  const _MarketSellBody({
    required this.username,
    required this.reputation,
  });

  final String username;
  final int reputation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 2, bottom: 2),
                child: Icon(Icons.tag_faces, size: 15),
              ),
              Text(
                'Reputation $reputation',
                style: textTheme.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MarketSellTrailing extends StatelessWidget {
  const _MarketSellTrailing({
    required this.quantity,
    required this.price,
  });

  final int quantity, price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // This is what just worked for the style.
      // ignore: no-magic-number
      height: 65,
      child: Row(
        children: [
          _MarketColumn(
            header: 'Quantity',
            value: quantity,
          ),
          Container(
            // This is what just worked for the style.
            // ignore: no-magic-number
            width: 20,
            // This is what just worked for the style.
            // ignore: no-magic-number
            height: 2,
            margin: const EdgeInsets.only(left: 8, top: 18, right: 8),
            color: context.theme.textTheme.bodyText2?.color,
          ),
          _MarketColumn(
            header: 'Platinum',
            value: price,
          ),
        ],
      ),
    );
  }
}

class _MarketColumn extends StatelessWidget {
  const _MarketColumn({required this.header, required this.value});

  final String header;
  final int value;

  @override
  Widget build(BuildContext context) {
    const stringPadding = 2;
    final textTheme = context.textTheme;
    final headerStyle =
        textTheme.caption?.copyWith(fontWeight: FontWeight.w500);
    final valueStyle =
        textTheme.headline5?.copyWith(fontWeight: FontWeight.w800);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(header, style: headerStyle),
        SizedBoxSpacer.spacerHeight6,
        Text('$value'.padLeft(stringPadding, '0'), style: valueStyle),
      ],
    );
  }
}
