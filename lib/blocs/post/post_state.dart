import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';

import '../../models/post_model.dart';

// blocs/post/post_state.dart

import '../../models/post_model.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
