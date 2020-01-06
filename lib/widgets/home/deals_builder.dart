import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'deal_widget.dart';

class DarvoPanel extends StatelessWidget {
  const DarvoPanel({Key key, this.deals}) : super(key: key);

  final List<DarvoDeal> deals;

  @override
  Widget build(BuildContext context) {
    return Tiles(
      title: 'Darvo Deals',
      child: PageStorage(
        key: dealskey,
        bucket: dealsBucket,
        child: Carousel(
          dotCount: deals.length,
          enableIndicator: deals.length > 1,
          children: deals.map((d) => DealWidget(deal: d)).toList(),
        ),
      ),
    );
  }
}
