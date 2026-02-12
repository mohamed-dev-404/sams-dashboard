part of 'add_user_cubit.dart';

@immutable
sealed class AddUserState {}

final class AddUserInitial extends AddUserState {}

final class AddUserLoading extends AddUserState {}

final class AddUserFailure extends AddUserState {
  final String errorMessage;
  AddUserFailure(this.errorMessage);
}

final class AddUserSuccess extends AddUserState {
  final String successMessage;
  AddUserSuccess(this.successMessage);
}
