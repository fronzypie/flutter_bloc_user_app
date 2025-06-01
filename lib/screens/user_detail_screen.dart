import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../models/post_model.dart';
import '../../models/todo_model.dart';
import '../../blocs/post/post_bloc.dart';
import '../../blocs/post/post_event.dart';
import '../../blocs/post/post_state.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_state.dart';
import '../../repositories/post_repository.dart';
import '../../repositories/user_repository.dart';
import 'create_post_screen.dart';
import '../blocs/post/post_event.dart';




class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(
          create: (_) => PostBloc(PostRepository())..add(FetchPosts(user.id)),
        ),
        BlocProvider<TodoBloc>(
          create: (_) => TodoBloc(UserRepository())..add(FetchTodos(user.id)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.firstName} ${user.lastName}'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${user.email}'),
              Text('Phone: ${user.phone}'),
              const SizedBox(height: 16),
              const Text('Posts:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PostLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      },
                    );
                  } else if (state is PostError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreatePostScreen(userId: user.id),
                    ),
                  );
                },
                child: const Text('Add Post'),
              ),
              const SizedBox(height: 24),
              const Text('Todos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is TodoLoaded) {
                    return ListView.builder(
                      itemCount: state.todos.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return ListTile(
                          title: Text(todo.todo),
                          trailing: Icon(
                            todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: todo.completed ? Colors.green : null,
                          ),
                        );
                      },
                    );
                  } else if (state is TodoError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
