import '../utils/dio/request.dart' show Request;

/// 请求示例
Future<Object> getDemo() async {
  return Request.get(
    '/m1/3617283-3245905-default/pet/1',
    queryParameters: {'corpId': 'e00fd7513077401013c0'},
  );
}

Future<Object> postDemo() async {
  return Request.post('/api', data: {});
}

Future<Object> putDemo() async {
  return Request.put('/api', data: {});
}
