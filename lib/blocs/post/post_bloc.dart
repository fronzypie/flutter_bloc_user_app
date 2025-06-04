import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../../models/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final List<Post> posts = await repository.fetchPostsByUser(event.userId);
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    if (state is PostLoaded) {
      final List<Post> updatedPosts = List.from((state as PostLoaded).posts)
        ..insert(0, event.post);
      emit(PostLoaded(updatedPosts));

    }
  }
}
