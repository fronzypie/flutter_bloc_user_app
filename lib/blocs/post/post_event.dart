import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';

import '../../models/post_model.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {
  final int userId;
  FetchPosts(this.userId);
}

class LoadPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;
  AddPost(this.post);
}
