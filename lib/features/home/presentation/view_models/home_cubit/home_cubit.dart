import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sams_dashboard/features/home/data/models/fetch_users_params.dart';
import 'package:sams_dashboard/features/home/data/models/user_response_model.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> getUsers({FetchUsersParams? params}) async {
    emit(HomeLoading());
    final result = await homeRepo.fetchUsers(params: params);

    result.fold(
      (failureMessage) => emit(HomeFailure(failureMessage)),

      (userResponse) => emit(HomeSuccess(userResponse)),
    );
  }
}
