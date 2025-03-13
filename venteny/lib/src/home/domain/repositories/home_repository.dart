import 'package:venteny/src/home/data/models/home_model.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/home_entity.dart';

abstract class HomeRepository {
  // TODO: Define HomeRepository interface

 const HomeRepository();

 ResultFuture<List<TaskEntity>> getTask();
 ResultFuture<int> deleteTask({required int id});
 ResultFuture<TaskEntity> createTask({required TaskEntity taskEntity});
 ResultFuture<bool> updateTask({required TaskEntity taskEntity});
 ResultFuture<List<TasksModel>> searchTask({String? title,int? status});

}
