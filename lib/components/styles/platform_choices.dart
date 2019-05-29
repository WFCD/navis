import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/styles/platform_icon.dart';
import 'package:navis/utils/enums.dart';

const pc = 'PC';
const ps4 = 'Sony PlayStation 4';
const xb1 = 'Microsoft Xbox One';
const swi = 'Nintendo Switch';

class PlatformChoice extends StatefulWidget {
  const PlatformChoice({Key key}) : super(key: key);

  @override
  PlatformChoiceState createState() => PlatformChoiceState();
}

class PlatformChoiceState extends State<PlatformChoice> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: BlocProvider.of<StorageBloc>(context),
      builder: (context, storageState) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PlatformIcon(platform: Platforms.pc),
            PlatformIcon(platform: Platforms.ps4),
            PlatformIcon(platform: Platforms.xb1),
            PlatformIcon(platform: Platforms.swi)
          ],
        );
      },
    );
  }
}
