// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/authentication_entity.dart';
import '../repositories/authentication_repository.dart';

class LoginUsecase extends UsecaseWithParams<void,LoginParams> {
  
const LoginUsecase(this._repository);

final AuthenticationRepository _repository;

// TODO: Implement Authentication usecase
  @override
  ResultFuture<AuthenticationEntity> call(LoginParams params) {
    // TODO: implement call Authentication
    
    return _repository.login(email: params.email,password: params.password);
    
  }
}


class LoginParams extends Equatable {
  final String email;
  final String password;
  const LoginParams({
    required this.email,
    required this.password,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}
