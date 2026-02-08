abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final dynamic user; //todo Replace with real UserModel
  LoginSuccess(this.user);
}
class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}