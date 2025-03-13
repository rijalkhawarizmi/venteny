import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/database.dart';
import '../models/home_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HomeRemoteDataSource {
  Future<List<TasksModel>> getTasks();
  Future<int> deleteTask({required int id});
  Future<TasksModel> createTask({required TasksModel taskModel});
  Future<bool> updateTask({required TasksModel taskModel});
  Future<List<TasksModel>> searchTask({ String? title, int? status});
}

class HomeRemoteDataSrcImpl implements HomeRemoteDataSource {
  // TODO: Implement HomeRemoteDataSource

  HomeRemoteDataSrcImpl(this._database);

  late DatabaseService _database;

  @override
  Future<List<TasksModel>> getTasks() async {
    try {
      final result = await _database.readAllNotes();
      print('hahaha ${result}');
      return result;
    } on DioException catch (e) {
      throw ApiException(e.message!);
    }
  }

  @override
  Future<TasksModel> createTask({required TasksModel taskModel}) async {
    // TODO: implement createTask
    try {
      final result = await _database.create(taskModel);
      return result.copy(id: taskModel.id);
    } on DatabaseException catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<int> deleteTask({required int id}) async {
    // TODO: implement deleteTask
    try {
      final result = await _database.delete(id);
      return result;
    } on DatabaseException catch (e) {
      throw ApiException(e.toString());
    }
  }
  
  @override
  Future<bool> updateTask({required TasksModel taskModel}) async {
    // TODO: implement updateTask
     
     try {
      final result = await _database.update(taskModel);
     
      return result;
    } on DatabaseException catch (e) {
      throw ApiException(e.toString());
    }
  }
  
  @override
  Future<List<TasksModel>> searchTask({ String? title, int? status}) async {
    // TODO: implement searchTask
     try {
      final result = await _database.searchTask(title: title,status: status);
      return result;
    } on DatabaseException catch (e) {
      throw ApiException(e.toString());
    }
  }
}
