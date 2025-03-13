// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {

  final String token;
  
  AuthenticationEntity({
    required this.token,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token];
  // TODO: Define AuthenticationEntity properties
}
