import 'dart:developer';

import 'package:riverpod_app/core/services_network/network_caller.dart';
import 'package:riverpod_app/core/services_network/network_response.dart';
import 'package:riverpod_app/core/utility/exception/debug_logger.dart';
import 'package:riverpod_app/features/auth/login/repository/login_repository.dart';
import 'package:riverpod_app/local_storage/auth_utility_controller.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool> login({required String email, required String password}) async {
    Map<String, String> requestBody = {"email": email, "password": password};

    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        "http://175.29.147.118/react/api-login-V2/",
        requestBody,
      );

      DebugLogger.printJsonResponse(
        tag: 'Login api',
        responseBody: response.body,
        statusCode: response.statusCode,
      );

      if (response.isSuccess) {
        AuthUtilityController.setAccessToken(
          token: response.body['access_token'],
        );
        AuthUtilityController.setRefreshToken(
          refreshToken: response.body['refresh_token'],
        );
        AuthUtilityController.setUserRole(userRole: response.body['role']);
        return true;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Error in login: $e');
      log('StackTrace: $stackTrace');
      throw Exception('Something went wrong while login');
    }
  }
}
