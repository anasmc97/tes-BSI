// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:untitled/core/di/app_module.dart' as _i892;
import 'package:untitled/core/di/storage_module.dart' as _i572;
import 'package:untitled/core/utils/interceptor/dio_error_interceptor.dart'
    as _i715;
import 'package:untitled/core/utils/interceptor/dio_http_interceptor.dart'
    as _i448;
import 'package:untitled/features/homepage/data/datasources/remote/user_remote_datasources.dart'
    as _i660;
import 'package:untitled/features/homepage/data/repositories/user_repository.dart'
    as _i506;
import 'package:untitled/features/homepage/domain/repositories/user_repository.dart'
    as _i42;
import 'package:untitled/features/homepage/domain/usecase/load_users_usecase.dart'
    as _i125;
import 'package:untitled/features/homepage/presentation/bloc/user_bloc.dart'
    as _i44;
import 'package:untitled/shared/flash/presentation/blocs/cubit/flash_cubit.dart'
    as _i560;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final storageModule = _$StorageModule();
    gh.factory<_i560.FlashCubit>(() => _i560.FlashCubit());
    gh.singleton<_i361.Dio>(() => appModule.dio);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreference,
      preResolve: true,
    );
    gh.lazySingleton<_i715.DioErrorInterceptor>(
        () => _i715.DioErrorInterceptor());
    gh.lazySingleton<_i448.DioHttpInterceptor>(
        () => _i448.DioHttpInterceptor());
    gh.lazySingleton<_i660.UserRemoteDataSource>(
        () => _i660.UserRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i42.UserRepository>(() => _i506.UserRepositoryImpl(
        remoteDataSource: gh<_i660.UserRemoteDataSource>()));
    gh.lazySingleton<_i125.LoadUsersUsecase>(
        () => _i125.LoadUsersUsecase(gh<_i42.UserRepository>()));
    gh.factory<_i44.UserBloc>(
        () => _i44.UserBloc(gh<_i125.LoadUsersUsecase>()));
    return this;
  }
}

class _$AppModule extends _i892.AppModule {}

class _$StorageModule extends _i572.StorageModule {}
