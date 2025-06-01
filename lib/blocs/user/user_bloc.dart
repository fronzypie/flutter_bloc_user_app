import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../repositories/user_repository.dart';
import '../../models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  int _skip = 0;
  final int _limit = 10;
  bool _isFetching = false;

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    _skip = 0;
    try {
      final users = await repository.fetchUsers(skip: _skip, limit: _limit);
      _skip += _limit;
      emit(UserLoaded(users: users, hasMore: users.length == _limit));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(LoadMoreUsers event, Emitter<UserState> emit) async {
    if (_isFetching || state is! UserLoaded) return;

    _isFetching = true;
    final currentState = state as UserLoaded;

    try {
      final moreUsers = await repository.fetchUsers(skip: _skip, limit: _limit);
      _skip += _limit;

      emit(UserLoaded(
        users: currentState.users + moreUsers,
        hasMore: moreUsers.length == _limit,
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
    _isFetching = false;
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final results = await repository.searchUsers(event.query);
      emit(UserLoaded(users: results, hasMore: false));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
