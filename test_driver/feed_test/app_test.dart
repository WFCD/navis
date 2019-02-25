import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Navis', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      driver.checkHealth();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    test('Observe scrolling behavior in feed tab', () async {
      final feed = find.byType('CustomScrollView');
      final sortie = find.byType('SculptureMissions');

      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(feed, sortie, dyScroll: 0.0);

        //expect(sortie, sortie);
      });

      final summary = TimelineSummary.summarize(timeline);

      summary.writeSummaryToFile('scrolling_summary', pretty: true);

      summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
