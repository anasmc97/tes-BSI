import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int? id,
    required String? name,
    required String? username,
    required String? email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromDomain(User form) => UserModel(
        id: form.id,
        name: form.name,
        username: form.username,
        email: form.email,
      );
}

extension UserModelX on UserModel {
  User toDomain() => User(
        id: id ?? 0,
        name: name ?? '',
        username: username ?? '',
        email: email ?? '',
      );
}
