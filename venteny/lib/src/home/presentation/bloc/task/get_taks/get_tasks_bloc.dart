import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/domain/entities/home_entity.dart';
import 'package:venteny/src/home/domain/usecases/get_usecase.dart';

part 'get_tasks_event.dart';
part 'get_tasks_state.dart';

class GetTasksBloc extends Bloc<GetTasksEvent, GetTasksState> {
  GetTasksBloc({required GetUsecase usecase})
      : _getUsecase = usecase,
        super(const GetTasksState()) {
    on<GetTasksEvent>(_getTask);
  }

  final GetUsecase _getUsecase;

  void _getTask(GetTasksEvent event, Emitter<GetTasksState> emit) async {
    emit(state.copyWith(status: StatusGetTasks.loading));
    final result = await _getUsecase();
    result.fold(
        (failure) => emit(state.copyWith(status: StatusGetTasks.failure)),
        (success) => emit(state.copyWith(
            status: StatusGetTasks.success, taskEntity: success)));
  }
}
