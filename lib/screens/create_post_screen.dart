import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post_model.dart';
import '../blocs/post/post_bloc.dart';
import '../blocs/post/post_event.dart';

class CreatePostScreen extends StatefulWidget {
  final int userId;

  const CreatePostScreen({super.key, required this.userId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: widget.userId,
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        tags: [],
        reactions: 0,
      );

      context.read<PostBloc>().add(AddPost(newPost));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) =>
                val == null || val.isEmpty ? 'Title required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: 4,
                validator: (val) =>
                val == null || val.isEmpty ? 'Body required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitPost,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
