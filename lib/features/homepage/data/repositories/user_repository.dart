import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/core/utils/resource_state/resource_state.dart';
import 'package:untitled/features/homepage/data/datasources/remote/user_remote_datasources.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';
import 'package:untitled/features/homepage/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ResourceState<List<User>>> loadUsers() {
    return remoteDataSource.loadUsers();
  }
}
