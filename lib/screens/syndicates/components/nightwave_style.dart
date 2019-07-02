import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import '../nightwaveChallenges.dart';

class NightWaveStyle extends StatelessWidget {
  void _navigateToChallenges(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => const NightwaveChallenges()));

  @override
  Widget build(BuildContext context) {
    final radio = BlocProvider.of<WorldstateBloc>(context);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        constraints: const BoxConstraints.expand(height: 100.0),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
                image: const AssetImage('assets/general/banner.webp'),
                fit: BoxFit.cover)),
        child: BlocBuilder(
          bloc: radio,
          builder: (_, state) {
            if (state is WorldstateLoaded) {
              return InkWell(
                  onTap: () => _navigateToChallenges(context),
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(34, 34, 34, .2)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('NIghtwave',
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: Colors.white, fontSize: 20)),
                            Text('Season ${state.nightwave.season + 1}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle)
                          ])));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
