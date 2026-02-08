import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_dashboard/features/auth/data/repos/auth_repo.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ignore: unused_field
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    // Implementation for {{BASE_URL}}/api/v1/auth/login
  }
}