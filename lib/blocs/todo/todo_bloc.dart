import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../../repositories/user_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserRepository userRepository;

  TodoBloc(this.userRepository) : super(TodoInitial()) {
    on<FetchTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await userRepository.fetchUserTodos(event.userId);
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos'));
      }
    });
  }
}
