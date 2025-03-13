import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/domain/usecases/update_usecase.dart';

import '../../../../domain/entities/home_entity.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc({required UpdateUsecase usecase})
      : _updateUsecase = usecase,
        super(const UpdateTaskState()) {
    on<UpdateTaskEvent>(_updateTask);
  }

  final UpdateUsecase _updateUsecase;
  void _updateTask(UpdateTaskEvent event, Emitter<UpdateTaskState> emit) async {
    final result = await _updateUsecase(UpdateParams(
        id: event.taskEntity.id,
        title: event.taskEntity.title,
        description: event.taskEntity.description,
        dueDate: event.taskEntity.dueDate,
        status: event.taskEntity.status));
    emit(state.copyWith(status: StatusUpdate.loading));
    result.fold((failure) => emit(state.copyWith(status: StatusUpdate.failure)),
        (success) => emit(state.copyWith(status: StatusUpdate.success)));
  }
}
