part of 'user_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class UserState implements _$UserState {
  const factory UserState({
    required List<User> users,
    required Option<Either<Failure, List<User>>> usersOrFailureOption,
    required Status status,
  }) = _UserState;

  factory UserState.initial() {
    return UserState(
      users: [],
      usersOrFailureOption: none(),
      status: Status.loading,
    );
  }
}
