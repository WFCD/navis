import 'package:navis/models/export.dart';

import 'rewards.dart';
import 'streamable.dart';
import 'worldstate.dart';

class Respiratory {
  final rewards = Rewards();
  final streamable = StreamableAPI();
  final worldstate = WorldstateAPI();

  Future<List<Reward>> getRewardImages(List<String> bountyRewards) async =>
      await rewards.rewards(bountyRewards);

  Future<String> getStreamableLink(String shortCode) =>
      streamable.fishVideos(shortCode);

  Future<WorldState> getState() async => worldstate.updateState();
}
