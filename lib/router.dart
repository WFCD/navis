import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:navis/screens/syndicate_bounties.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:worldstate_model/models/syndicate.dart';

final router = Router();

final syndicateHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final faction = stringToSyndicateFaction(params['faction'][0]);
    final bounties =
        json.decode(params['bounties'][0]).cast<Map<String, dynamic>>();

    return SyndicateJobs(
      faction: faction,
      jobs: bounties.map<Job>((m) => Job.fromJson(m)).toList(),
    );
  },
);

void defineRoutes(Router router) {
  router.define(
    '/syndicates/:faction/:bounties',
    handler: syndicateHandler,
    transitionType: TransitionType.material,
  );
}

void navigateToBounties(BuildContext context, Syndicate syn) {
  final faction = syn.name;
  final bounties = json
      .encode(syn.jobs.map<Map<String, dynamic>>((j) => j.toJson()).toList());

  Navigator.of(context).pushNamed('/syndicates/$faction/$bounties');
}
