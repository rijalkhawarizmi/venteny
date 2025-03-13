part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent({required this.email,required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email,password];
}
