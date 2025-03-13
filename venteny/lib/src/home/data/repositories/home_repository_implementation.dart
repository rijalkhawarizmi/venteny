import 'package:venteny/src/home/data/models/home_model.dart';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImplementation extends HomeRepository {
  HomeRepositoryImplementation(this._homeRemoteDataSource);

  final HomeRemoteDataSource _homeRemoteDataSource;

  @override
  ResultFuture<List<TaskEntity>> getTask() async {
    // TODO: implement getTask
    try {
      List<TaskEntity> taskEntity = await _homeRemoteDataSource.getTasks();
      return Right(taskEntity);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<TaskEntity> createTask({required TaskEntity taskEntity}) async {
    // TODO: implement createTask
    try {
      TasksModel tasksModel= TasksModel(id: taskEntity.id, title: taskEntity.title, description: taskEntity.description, dueDate: taskEntity.dueDate, status: taskEntity.status);
      TaskEntity result = await _homeRemoteDataSource.createTask(taskModel:tasksModel);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<int> deleteTask({required int id})async {
    // TODO: implement deleteTask
    try {
      int result = await _homeRemoteDataSource.deleteTask(id: id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<bool> updateTask({required TaskEntity taskEntity}) async {
    // TODO: implement updateTask
    try {
      TasksModel tasksModel= TasksModel(id: taskEntity.id, title: taskEntity.title, description: taskEntity.description, dueDate: taskEntity.dueDate, status: taskEntity.status);
      bool result = await _homeRemoteDataSource.updateTask(taskModel:tasksModel);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<List<TasksModel>> searchTask({String? title, int? status}) async {
    // TODO: implement searchTask
     try {
      List<TasksModel> result = await _homeRemoteDataSource.searchTask(title: title,status: status);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
