import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:venteny/src/home/domain/entities/home_entity.dart';
import 'package:venteny/src/home/domain/usecases/search_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required SearchUsecase usecase})
      : _searchUsecase = usecase,
        super(SearchState()) {
    on<SearchEvent>(_searchTask);
  }
  final SearchUsecase _searchUsecase;
  void _searchTask(SearchEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: StatusSearch.loading,title: event.title));
    final result = await _searchUsecase(
        SearchParams(title: event.title ?? "", status: event.status));
    result.fold(
        (failure) => emit(state.copyWith(status: StatusSearch.failure)),
        (success) => emit(
            state.copyWith(status: StatusSearch.success, taskEntity: success)));
  }
}
