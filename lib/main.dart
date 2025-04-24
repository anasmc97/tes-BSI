import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/extensions/context_extensions.dart';
import 'package:untitled/core/utils/constants.dart';
import 'package:untitled/features/homepage/presentation/bloc/user_bloc.dart';
import 'package:untitled/features/homepage/presentation/ui/homepage.dart';
import 'package:untitled/injector.dart';

import 'shared/flash/presentation/blocs/cubit/flash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  FlutterError.onError = (errorDetails) {
    if (!kDebugMode) {
      if (errorDetails.exception is SocketException) {
        return;
      }
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      return false;
    }

    if (error is SocketException) {
      return false;
    }
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<UserBloc>()
              ..add(
                const UserEvent.loadUsers(),
              )),
        BlocProvider(
          create: (context) => getIt<FlashCubit>(),
        ),
      ],
      child: BlocListener<FlashCubit, FlashState>(
        listener: (context, state) {
          state.when(
            disappeared: () => null,
            appeared: (message) => context.showSnackbar(
              message: message,
            ),
          );
        },
        child: MaterialApp(
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          title: 'Get User Data App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
