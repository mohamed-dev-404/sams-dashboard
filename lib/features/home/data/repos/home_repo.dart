import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/features/home/data/models/create_user_params.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/role_model.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/data/models/user_response_model.dart';

abstract class HomeRepo {
  Future<Either<String, UserResponseModel>> fetchUsers({
    FetchUsersParams? params,
  });

  Future<Either<String, UserModel>> toggleUserActivation({
    required String userId,
  });

  Future<Either<String, UserModel>> changeUserRole({
    required String userId,
    required String roleId,
  });

  Future<Either<String, String>> createUser({
    required CreateUserParams params,
  });

  Future<Either<String, List<RoleModel>>> fetchRoles();
}
