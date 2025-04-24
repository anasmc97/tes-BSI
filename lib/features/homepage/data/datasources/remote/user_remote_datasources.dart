import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/core/extensions/response_ext.dart';
import 'package:untitled/core/utils/constants.dart';
import 'package:untitled/core/utils/resource_state/resource_state.dart';
import 'package:untitled/features/homepage/data/models/user_model.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';

abstract class UserRemoteDataSource {
  Future<ResourceState<List<User>>> loadUsers();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this._dio);
  final baseUrl = ConstantValue.url;
  final Dio _dio;

  @override
  Future<ResourceState<List<User>>> loadUsers() async {
    return await _dio
        .get(
      '$baseUrl/users',
    )
        .mapToEntity(
      (e) {
        final response = json.decode(e);
        final users =
            (response as List?)?.map((e) => UserModel.fromJson(e)).toList() ??
                [];

        return users.map((e) => e.toDomain()).toList();
      },
    );
  }
}
