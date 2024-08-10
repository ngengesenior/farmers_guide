import 'package:farmers_guide/networking/interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class _HttpClient {
  static InterceptedHttp getInstance() {
    return InterceptedHttp.build(
      interceptors: [MyInterceptor()],
    );
  }
}

final httpClient = _HttpClient.getInstance();
