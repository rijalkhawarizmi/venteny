// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class CreateUsecase extends UsecaseWithParams<TaskEntity, CreateParams> {
  const CreateUsecase(this._repository);

  final HomeRepository _repository;

// TODO: Implement Home usecase
  @override
  ResultFuture<TaskEntity> call(CreateParams params) {
    // TODO: implement call Home
    return _repository.createTask(
        taskEntity: TaskEntity(
            id: params.id,
            title: params.title,
            description: params.description,
            dueDate: params.dueDate,
            status: params.status));
  }
}

class CreateParams extends Equatable {
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final int status;
  const CreateParams({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object> get props => [id,title, description, dueDate, status];
}
