// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../../domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {

  // TODO: Implement AuthenticationModel
  final String token;

  AuthenticationModel({required this.token}):super(token: token);
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory AuthenticationModel.fromMap(Map<String, dynamic> map) {
    return AuthenticationModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationModel.fromJson(String source) => AuthenticationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
