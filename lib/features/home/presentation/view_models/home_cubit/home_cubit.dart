import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/role_model.dart';
import 'package:sams_dashboard/features/home/data/models/user_response_model.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  UserResponseModel? _currentUsers;
  List<RoleModel> _roles = [];
  FetchUsersParams _currentParams = FetchUsersParams();

  //? . Fetch all init data
  Future<void> initHome() async {
    emit(HomeLoading());

    final results = await Future.wait([
      homeRepo.fetchRoles(),
      homeRepo.fetchUsers(),
    ]);

    final rolesResult = results[0] as Either<String, List<RoleModel>>;
    final usersResult = results[1] as Either<String, UserResponseModel>;

    _roles = rolesResult.getOrElse(() => []);

    usersResult.fold(
      (error) => emit(HomeFailure(error)),
      (userResponse) {
        _currentUsers = userResponse;
        emit(HomeSuccess(userResponse: userResponse));
      },
    );
  }

  //* 1. Fetch Users
  Future<void> getUsers({FetchUsersParams? params}) async {
    if (params != null) {
      _currentParams = params;
    }
    emit(HomeLoading());
    final result = await homeRepo.fetchUsers(params: _currentParams);

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (userResponse) {
        _currentUsers = userResponse;
        emit(HomeSuccess(userResponse: userResponse));
      },
    );
  }

  Future<void> updatePage(int newPage) async {
    _currentParams = _currentParams.copyWith(page: newPage);
    await getUsers();
  }

  //* 2. Toggle Activation
  Future<void> toggleActivation({required String userId}) async {
    if (_currentUsers == null) return;
    final previousResponse = _currentUsers;

    final updatedList = _currentUsers!.users.map((user) {
      if (user.id == userId) {
        return user.copyWith(
          status: user.status == UserStatus.active
              ? UserStatus.inactive
              : UserStatus.active,
        );
      }
      return user;
    }).toList();
    _currentUsers = _currentUsers!.copyWith(users: updatedList);

    emit(HomeSuccess(userResponse: _currentUsers!));

    final result = await homeRepo.toggleUserActivation(userId: userId);

    result.fold(
      (error) {
        _currentUsers = previousResponse;
        emit(
          HomeSuccess(userResponse: _currentUsers!),
        );

        emit(HomeActionFailure(error));
      },
      (updatedUser) {
        emit(HomeActionSuccess('User status updated successfully'));
      },
    );
  }

  //* 3. Change Role
  Future<void> changeUserRole({
    required String userId,
    required UserRole newRole,
  }) async {
    if (_currentUsers == null) return;
    final previousResponse = _currentUsers;

    final roleModel = _roles.firstWhere(
      (r) => r.role == newRole,
      orElse: () => RoleModel(id: '', role: newRole),
    );

    if (roleModel.id.isEmpty) {
      emit(HomeActionFailure('Role ID not found for ${newRole.name}'));
      return;
    }

    final updatedList = _currentUsers!.users.map((user) {
      if (user.id == userId) {
        return user.copyWith(
          role: user.role == UserRole.instructor
              ? UserRole.student
              : UserRole.instructor,
        );
      }
      return user;
    }).toList();

    _currentUsers = _currentUsers!.copyWith(users: updatedList);

    emit(HomeSuccess(userResponse: _currentUsers!));

    final result = await homeRepo.changeUserRole(
      userId: userId,
      roleId: roleModel.id,
    );

    result.fold(
      (error) {
        _currentUsers = previousResponse;
        emit(HomeSuccess(userResponse: _currentUsers!));
        emit(HomeActionFailure(error));
      },
      (updatedUser) {
        emit(
          HomeActionSuccess(
            'User role updated to ${newRole.name} successfully',
          ),
        );
      },
    );
  }
}
