import 'package:untitled/core/utils/resource_state/resource_state.dart';
import 'package:untitled/features/homepage/domain/entity/user.dart';

abstract class UserRepository {
  Future<ResourceState<List<User>>> loadUsers();
}
