import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/domain/entities/home_entity.dart';
import 'package:venteny/src/home/domain/usecases/create_usecase.dart';
part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({required CreateUsecase usecase})
      : _createUsecase = usecase,
        super(const CreateTaskState()) {
    on<CreateTaskEvent>(_createTask);
  }

  final CreateUsecase _createUsecase;
  void _createTask(CreateTaskEvent event, Emitter<CreateTaskState> emit) async {
    final result = await _createUsecase(CreateParams(
        id: event.taskEntity.id,
        title: event.taskEntity.title,
        description: event.taskEntity.description,
        dueDate: event.taskEntity.dueDate,
        status: event.taskEntity.status));
    emit(state.copyWith(status: StatusCreate.loading));
    await Future.delayed(const Duration(seconds: 1));
    result.fold(
        (failure) => emit(state.copyWith(status: StatusCreate.failure)),
        (success) => emit(
            state.copyWith(status: StatusCreate.success, isCreated: true)));
  }
}
