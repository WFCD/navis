import 'dart:async';
import 'dart:convert';
import 'package:codable/codable.dart';
import 'package:http/http.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/metric_httpClient.dart';

class Rewards {
  final MetricHttpClient _metricHttpClient = MetricHttpClient(Client());

  Future<List<Reward>> rewards(List<String> bountyRewards) async {
    final List<Reward> imageList = await retriveRewards(bountyRewards);
    final List<Reward> parseRewards = [];
    final nonexistent = Reward()
      ..rewardName = 'reward doesn\'t exist'
      ..imagePath = null;

    for (int i = 0; i < bountyRewards.length; i++) {
      final image = List.from(imageList);
      try {
        image.retainWhere(
            (image) => bountyRewards[i].contains(image.rewardName) == true);
        parseRewards.add(image.first);
      } catch (err) {
        parseRewards.add(nonexistent);
      }
    }

    return parseRewards;
  }

  Future<List<Reward>> retriveRewards(List<String> bountyRewards) async {
    final Request request =
        Request('GET', Uri.parse('http://142.93.23.157/rewards'));

    final StreamedResponse response = await _metricHttpClient.send(request);

    return await response.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((r) => r)
        .map((r) => Reward()..decode(KeyedArchive.unarchive(r)))
        .toList();
  }
}
