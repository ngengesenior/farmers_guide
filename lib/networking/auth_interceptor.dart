import 'package:http_interceptor/http_interceptor.dart';
import 'package:farmers_guide/services/token_service.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInterceptor extends InterceptorContract {
  MyInterceptor();

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final token = await TokenService.getAccessToken();
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] = "Bearer $token";

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await userMeState.initialise(isReset: true);
    }
    return response;
  }
}
