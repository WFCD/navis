import 'package:http/http.dart';
import 'package:firebase_performance/firebase_performance.dart';

class MetricHttpClient extends BaseClient {
  MetricHttpClient(this._inner);

  final Client _inner;

  static bool isDebug = false;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final HttpMetric metric = FirebasePerformance.instance
        .newHttpMetric(request.url.toString(), HttpMethod.Get);

    StreamedResponse response;

    assert(isDebug = true);
    if (isDebug) {
      response = await _inner.send(request);
    } else {
      await metric.start();

      try {
        response = await _inner.send(request);
        metric
          ..responsePayloadSize = response.contentLength
          ..responseContentType = response.headers['Content-Type']
          ..requestPayloadSize = request.contentLength
          ..httpResponseCode = response.statusCode;
      } finally {
        await metric.stop();
      }
    }

    return response;
  }
}
