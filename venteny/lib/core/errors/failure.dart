import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;
  String get errorMessage => message;

  @override
  List<Object> get props => [message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message});
  ApiFailure.fromException(ApiException apiException)
      : this(message: apiException.message);
}
