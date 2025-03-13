import 'package:venteny/core/utils/typedef.dart';
import 'package:venteny/src/authentication/domain/entities/authentication_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  AuthenticationRepositoryImplementation(this._authenticationRemoteDataSource);

  final AuthenticationRemoteDataSource _authenticationRemoteDataSource; 

  @override
  ResultFuture<AuthenticationEntity> login({required String email,required String password}) async {
    // TODO: implement yourFunctionName
    try {
      AuthenticationEntity authenticationEntity = await _authenticationRemoteDataSource.login(email: email,password: password);
      return Right(authenticationEntity);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  
 
}

