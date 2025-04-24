import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/presentation/mixins/failure_message_handler.dart';
import 'package:untitled/core/utils/colors.dart';
import 'package:untitled/features/homepage/presentation/bloc/user_bloc.dart';

class HomePage extends StatelessWidget with FailureMessageHandler {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Users'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.usersOrFailureOption.fold(
            () => null,
            (either) =>
                either.fold((l) => handleFailure(context, l), (r) => null),
          );
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.grayScale100,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0].toUpperCase()),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('@${user.username}'),
                        SizedBox(height: 2),
                        Text(
                          user.email,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
