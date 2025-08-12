import '../models/common.m.dart';
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

/// 获取APP最新版本号, 演示更新APP组件
Future<NewVersionData> getNewVersion() async {
  try {
    // 替换为你的真实请求接口
    var res = await Request.get(
      'https://api.jsonbin.io/v3/b/YOUR_BIN_ID', // 替换为你的实际链接
      queryParameters: {},
    );

    // 如果使用jsonbin.io，数据在record字段中
    var responseData = res['record'] ?? res;
    var resData = NewVersionRes.fromJson(responseData);
    return (resData.data ?? {}) as NewVersionData;
  } catch (e) {
    // 网络错误时返回默认配置（不会触发更新）
    var resData = NewVersionRes.fromJson({
      "code": "0",
      "message": "success",
      "data": {
        "version": "1.0.0", // 比当前版本低，不会触发更新
        "info": ["网络错误，无法检查更新"]
      }
    });
    return (resData.data ?? {}) as NewVersionData;
  }
}
