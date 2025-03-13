import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/domain/usecases/delete_usecase.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc({required DeleteUsecase usecase}) : _deleteUsecase=usecase, super(const DeleteTaskState()) {
    on<DeleteTaskEvent>(_deleteTask);
  }
   final DeleteUsecase _deleteUsecase;

  void _deleteTask(DeleteTaskEvent event, Emitter<DeleteTaskState> emit) async {
    emit(state.copyWith(status: StatusDelete.loading));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _deleteUsecase(DeleteParams(id: event.id));
    result.fold(
        (failure) => emit(state.copyWith(status: StatusDelete.failure)),
        (success) => emit(state.copyWith(
            status: StatusDelete.success)));
  }
}
