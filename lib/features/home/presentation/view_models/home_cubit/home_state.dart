part of 'home_cubit.dart';

//* 1. Base State
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}

final class HomeSuccess extends HomeState {
  final UserResponseModel userResponse;
  HomeSuccess({required this.userResponse});
}

//* 2. Side Effects States
sealed class HomeActionState extends HomeState {}

final class HomeActionLoading extends HomeActionState {}

final class HomeActionSuccess extends HomeActionState {
  final String message;
  HomeActionSuccess(this.message);
}

final class HomeActionFailure extends HomeActionState {
  final String errorMessage;
  HomeActionFailure(this.errorMessage);
}
