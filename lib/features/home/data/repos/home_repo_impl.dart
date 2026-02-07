import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/core/errors/exceptions/api_exception.dart';
import 'package:sams_dashboard/core/network/api_consumer.dart';
import 'package:sams_dashboard/core/utils/constants/api_endpoints.dart';
import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/features/home/data/models/create_user_params.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/role_model.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/data/models/user_response_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiConsumer api;

  HomeRepoImpl(this.api);

  @override
  Future<Either<String, UserResponseModel>> fetchUsers({
    FetchUsersParams? params,
  }) async {
    final String errorMessage;
    try {
      final response = await api.get(
        EndPoints.users,
        queryParameters: params?.toJson() ?? FetchUsersParams().toJson(),
      );
      return Right(UserResponseModel.fromJson(response));
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      errorMessage = e.toString();
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, UserModel>> toggleUserActivation({
    required String userId,
  }) async {
    final String errorMessage;
    try {
      final response = await api.patch(
        EndPoints.toggleUserActivation(userId),
      );
      return Right(UserModel.fromJson(response[ApiKeys.data]));
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      errorMessage = e.toString();
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, UserModel>> changeUserRole({
    required String userId,
    required String roleId,
  }) async {
    final String errorMessage;

    try {
      final response = await api.patch(
        EndPoints.changeRole(userId),
        data: {
          ApiKeys.roleId: roleId,
        },
      );

      return Right(UserModel.fromJson(response[ApiKeys.data]));
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      errorMessage = e.toString();
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> createUser({
    required CreateUserParams params,
  }) async {
    final String errorMessage;
    try {
      final response = await api.post(
        EndPoints.users,
        data: params.toJson(),
      );
      return Right(response[ApiKeys.message] as String? ?? 'Success');
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      errorMessage = e.toString();
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, List<RoleModel>>> fetchRoles() async {
    final String errorMessage;
    try {
      final response = await api.get(EndPoints.roles);

      final List dataList = response[ApiKeys.data] as List? ?? [];

      final List<RoleModel> roles = dataList
          .map((item) => RoleModel.fromJson(item))
          .toList();

      return Right(roles);
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      errorMessage = e.toString();
      return Left(errorMessage);
    }
  }
}
