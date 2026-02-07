import 'package:bloc/bloc.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeState());

  //* 1. Fetch Users
  Future<void> getUsers({FetchUsersParams? params}) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await homeRepo.fetchUsers(params: params);

    result.fold(
      (failure) =>
          emit(state.copyWith(status: HomeStatus.failure, errMessage: failure)),
      (userResponse) => emit(
        state.copyWith(status: HomeStatus.success, users: userResponse.users),
      ),
    );
  }

  //* 2. Toggle Activation

  Future<void> toggleActivation({required String userId}) async {
    final List<UserModel> previousUsers = List.from(state.users);

    final updatedUsers = state.users.map((user) {
      if (user.id == userId) {
        final newStatus = user.status == UserStatus.active
            ? UserStatus.inactive
            : UserStatus.active;
        return user.copyWith(status: newStatus);
      }
      return user;
    }).toList();

    emit(
      state.copyWith(
        users: updatedUsers,
        actionStatus: HomeStatus.loading,
      ),
    );

    final result = await homeRepo.toggleUserActivation(userId: userId);

    result.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            users: previousUsers,
            actionStatus: HomeStatus.failure,
            actionMessage: errorMessage,
          ),
        );
        emit(state.copyWith(actionStatus: HomeStatus.initial));
      },
      (updatedUser) {
        emit(state.copyWith(actionStatus: HomeStatus.success));
      },
    );
  }
}
