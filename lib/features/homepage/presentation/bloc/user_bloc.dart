import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/core/domain/failures/failure.codegen.dart';
import 'package:untitled/core/domain/usecases/use_case.dart';
import 'package:untitled/core/extensions/dartz_extensions.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';
import 'package:untitled/features/homepage/domain/usecase/load_users_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._loadUsers,
  ) : super(UserState.initial()) {
    on<LoadUsers>(_onLoadUsers);
  }

  final LoadUsersUsecase _loadUsers;

  FutureOr<void> _onLoadUsers(
    LoadUsers event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _loadUsers(NoParams());

    if (result.isLeft()) {
      emit(
        state.copyWith(
          usersOrFailureOption: optionOf(
            left(result.getLeft()!),
          ),
          status: Status.initial,
        ),
      );
    }
    if (result.isRight()) {
      emit(
        state.copyWith(
          usersOrFailureOption: optionOf(
            right(result.getRight()!),
          ),
        ),
      );
      emit(
        state.copyWith(
          usersOrFailureOption: none(),
          users: result.getRight()!,
          status: Status.success,
        ),
      );
      emit(
        state.copyWith(status: Status.initial),
      );
    }
  }
}
