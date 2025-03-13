// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/home_repository.dart';

class DeleteUsecase extends UsecaseWithParams<int, DeleteParams> {
  const DeleteUsecase(this._repository);

  final HomeRepository _repository;

// TODO: Implement Home usecase
  @override
  ResultFuture<int> call(DeleteParams params) {
    // TODO: implement call Home

    return _repository.deleteTask(id: params.id);
  }
}

class DeleteParams extends Equatable {
  final int id;

  const DeleteParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
