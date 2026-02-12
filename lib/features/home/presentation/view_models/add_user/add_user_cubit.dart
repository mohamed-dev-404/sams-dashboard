import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sams_dashboard/features/home/data/models/create_user_params.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit(this.homeRepo) : super(AddUserInitial());

  final HomeRepo homeRepo;

  Future<void> createUser(CreateUserParams params) async {
    emit(AddUserLoading());

    final rolesResult = await homeRepo.fetchRoles();

    await rolesResult.fold(
      (error) async => emit(AddUserFailure(' Failed to fetch roles: $error')),
      (rolesList) async {
        try {
          final matchedRole = rolesList.firstWhere(
            (r) => r.role.name == params.roleId,
          );

          final updatedParams = CreateUserParams(
            name: params.name,
            email: params.email,
            academicId: params.academicId,
            roleId: matchedRole.id,
            password: params.password,
          );

          final result = await homeRepo.createUser(params: updatedParams);

          result.fold(
            (error) => emit(AddUserFailure(error)),
            (message) => emit(AddUserSuccess(message)),
          );
        } catch (e) {
          emit(AddUserFailure(e.toString()));
        }
      },
    );
  }
}
