import 'package:dio/dio.dart';
import '../../../../core/config/api_services.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/authentication_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthenticationModel> login(
      {required String email, required String password});
}

class AuthenticationRemoteDataSrcImpl
    implements AuthenticationRemoteDataSource {
  // TODO: Implement AuthenticationRemoteDataSource

  AuthenticationRemoteDataSrcImpl(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<AuthenticationModel> login(
      {required String email, required String password}) async {
    try {
      final response = await _apiServices.postRequest(
          path: "/api/login", rawJson: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return AuthenticationModel.fromMap(response.data);
      }
      throw ApiException(response.data);
    } on DioException catch (e) {
      throw ApiException(e.message ?? "failure to login");
    }
  }
}
