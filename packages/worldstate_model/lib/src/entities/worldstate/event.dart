import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

import 'job.dart';
import 'reward.dart';

class Event extends WorldstateObject {
  const Event({
    String id,
    DateTime activation,
    DateTime expiry,
    this.faction,
    this.affiliatedWith,
    this.description,
    this.victimNode,
    this.node,
    this.tooltip,
    this.maximumScore,
    this.currentScore,
    this.health,
    this.rewards,
    this.interimSteps,
    this.jobs,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String faction, description, victimNode, node, tooltip, affiliatedWith;
  final num health, currentScore, maximumScore;
  final List<Reward> rewards;
  final List<InterimStep> interimSteps;
  final List<Job> jobs;

  double get eventHealth {
    return (health ??
            (100 - ((currentScore ?? 0.0) / (maximumScore ?? 0.0)) * 100))
        .toDouble();
  }

  List<Reward> get eventRewards {
    final _rewards = List<Reward>.from(rewards);

    return _rewards
      ..addAll(interimSteps?.map<Reward>((i) => i.reward) ?? [])
      ..removeWhere((r) => r.itemString.isEmpty);
  }

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        faction,
        affiliatedWith,
        description,
        victimNode,
        node,
        tooltip,
        health,
        currentScore,
        maximumScore,
        rewards,
        interimSteps,
        jobs
      ]);
  }
}

class InterimStep extends Equatable {
  const InterimStep({this.goal, this.reward});

  final int goal;
  final Reward reward;

  @override
  List<Object> get props => [goal, reward];
}
