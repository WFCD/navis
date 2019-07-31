import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart';

class MetricHttpClient extends BaseClient {
  MetricHttpClient(this._inner);

  final Client _inner;

  @override
  Future<Response> get(url, {Map<String, String> headers}) async {
    final HttpMetric metric =
        FirebasePerformance.instance.newHttpMetric(url, HttpMethod.Get);

    await metric.start();

    Response response;
    try {
      response = await _inner.get(url);
      metric
        ..responsePayloadSize = response.contentLength ?? 0
        ..responseContentType = response.headers['Content-Type']
        ..requestPayloadSize = response.request.contentLength ?? 0
        ..httpResponseCode = response.statusCode;
    } finally {
      await metric.stop();
    }

    return response;
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final HttpMetric metric = FirebasePerformance.instance
        .newHttpMetric(request.url.toString(), HttpMethod.Get);

    await metric.start();

    StreamedResponse response;
    try {
      response = await _inner.send(request);
      metric
        ..responsePayloadSize = response.contentLength ?? 0
        ..responseContentType = response.headers['Content-Type']
        ..requestPayloadSize = request.contentLength ?? 0
        ..httpResponseCode = response.statusCode;
    } finally {
      await metric.stop();
    }

    return response;
  }
}
