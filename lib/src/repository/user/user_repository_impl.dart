import 'dart:developer';
import 'dart:io';
import 'package:clinic_core/clinic_core.dart';
import 'package:dio/dio.dart';
import 'package:lab_clinicas_self_service/src/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) =
          await restClient.unAuth.post('/auth', data: {'email': email, 'password': password, 'admin': true});
      return Right(accessToken);
    } on DioException catch (e, s) {
      log('Error ao realizar o login', error: e, stackTrace: s);

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) => Left(AuthUnauthorizedException()),
        _ => Left(AuthError(message: 'Erro ao realizar o login')),
      };
    }
  }
}
