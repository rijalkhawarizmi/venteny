// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/data/models/home_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/home_repository.dart';

class SearchUsecase extends UsecaseWithParams<List<TasksModel>, SearchParams> {
  const SearchUsecase(this._repository);

  final HomeRepository _repository;

// TODO: Implement Home usecase
  @override
  ResultFuture<List<TasksModel>> call(SearchParams params) {
    // TODO: implement call Home
    return _repository.searchTask(title: params.title, status: params.status);
  }
}

class SearchParams extends Equatable {
  final String? title;
  final int? status;

  const SearchParams({
     this.title,
     this.status,
  });

  @override
  List<Object?> get props => [title, status];
}
