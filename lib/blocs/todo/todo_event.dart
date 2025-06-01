import 'package:equatable/equatable.dart';

abstract class TodoEvent {}

class FetchTodos extends TodoEvent {
  final int userId;

  FetchTodos(this.userId);
}

