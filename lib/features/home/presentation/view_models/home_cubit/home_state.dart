part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

// General Page Loading (Initial fetch)
class HomeLoading extends HomeState {}

// Success state for fetching the list
class HomeSuccess extends HomeState {
  final UserResponseModel userResponse;
  HomeSuccess({required this.userResponse});
}

// Global failure (Page load failed)
class HomeFailure extends HomeState {
  final String errMessage;
  HomeFailure(this.errMessage);
}

// Action States (For Create, Toggle, Change Role)
class HomeActionLoading extends HomeState {}

class HomeActionSuccess extends HomeState {
  final String message;
  HomeActionSuccess(this.message);
}

class HomeActionFailure extends HomeState {
  final String errMessage;
  HomeActionFailure(this.errMessage);
}

