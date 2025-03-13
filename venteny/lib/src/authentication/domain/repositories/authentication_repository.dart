
import '../../../../core/utils/typedef.dart';
import '../entities/authentication_entity.dart';

abstract class AuthenticationRepository {
  // TODO: Define AuthenticationRepository interface

 const AuthenticationRepository();

 ResultFuture<AuthenticationEntity> login({required String email,required String password});

}
