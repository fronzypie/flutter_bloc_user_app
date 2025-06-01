import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/post/post_event.dart';
import 'blocs/user/user_event.dart';
import 'repositories/post_repository.dart';
import 'blocs/post/post_bloc.dart';
import 'screens/user_list_screen.dart';  // Adjust the path if needed

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'repositories/user_repository.dart';
import 'screens/user_list_screen.dart';  // your UserListScreen import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(repository: userRepository)..add(FetchUsers()),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserListScreen(),
      ),
    );
  }
}
