import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../screens/user_detail_screen.dart';

import '../blocs/post/post_bloc.dart';
import '../repositories/post_repository.dart';

import '../blocs/todo/todo_bloc.dart';
import '../repositories/user_repository.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<PostBloc>(
                  create: (_) => PostBloc(PostRepository()),
                ),
                BlocProvider<TodoBloc>(
                  create: (_) => TodoBloc(UserRepository()),
                ),
              ],
              child: UserDetailScreen(user: user),
            ),
          ),
        );
      },
    );
  }
}
