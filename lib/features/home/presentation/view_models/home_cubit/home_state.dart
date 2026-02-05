part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserResponseModel userResponse;
  HomeSuccess(this.userResponse);
}

class HomeFailure extends HomeState {
  final String errMessage;
  HomeFailure(this.errMessage);
}
