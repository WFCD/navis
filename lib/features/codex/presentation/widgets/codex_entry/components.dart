import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class ItemComponents extends StatelessWidget {
  const ItemComponents({Key key, @required this.components}) : super(key: key);

  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Wrap(
        children: [],
      ),
    );
  }
}
