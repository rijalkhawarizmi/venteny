// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum StatusLogin { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({this.status=StatusLogin.initial,this.token=""});
  final StatusLogin status;
  final String token;

  @override
  List<Object> get props => [status,token];

  LoginState copyWith({
    StatusLogin? status,
    String? token,
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }
}
