import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/user_response_model.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  //* 1. Fetch Users
  Future<void> getUsers({FetchUsersParams? params}) async {
    emit(HomeLoading());
    final result = await homeRepo.fetchUsers(params: params);

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (userResponse) => emit(HomeSuccess(userResponse: userResponse)),
    );
  }

  //* 2. Toggle Activation
  Future<void> toggleActivation({required String userId}) async {
    // We don't emit HomeLoading here to avoid flickering the whole screen
    final result = await homeRepo.toggleUserActivation(userId: userId);

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (user) {
        emit(HomeActionSuccess('User status updated: ${user.name}'));
        getUsers(); // Refresh list to show new status
      },
    );
  }
}
