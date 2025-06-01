import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {}

class LoadMoreUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;

  SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}