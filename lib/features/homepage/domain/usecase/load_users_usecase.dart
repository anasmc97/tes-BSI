import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/core/domain/failures/failure.codegen.dart';
import 'package:untitled/core/domain/usecases/use_case.dart';
import 'package:untitled/core/extensions/exception_ext.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';
import 'package:untitled/features/homepage/domain/repositories/user_repository.dart';

@lazySingleton
class LoadUsersUsecase implements UseCase<List<User>, NoParams> {
  final UserRepository repository;

  LoadUsersUsecase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    try {
      final response = await repository.loadUsers();
      return response.map(
        success: (e) => right(e.data),
        failure: (e) => left(
          Failure.serverFailure(
            message: e.exception.getMessage,
          ),
        ),
      );
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      return left(
        Failure.serverFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
