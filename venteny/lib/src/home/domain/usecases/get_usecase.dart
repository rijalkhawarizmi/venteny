import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class GetUsecase extends UsecaseWithoutParams<void> {
  
const GetUsecase(this._repository);

final HomeRepository _repository;

// TODO: Implement Home usecase
  @override
  ResultFuture<List<TaskEntity>> call() {
    // TODO: implement call Home
    
    return _repository.getTask();
    
  }
}

