part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<UserModel> users;
  final String? errMessage;

  final HomeStatus actionStatus;
  final String? actionMessage;

  HomeState({
    this.status = HomeStatus.initial,
    this.users = const [],
    this.errMessage,
    this.actionStatus = HomeStatus.initial,
    this.actionMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<UserModel>? users,
    String? errMessage,
    HomeStatus? actionStatus,
    String? actionMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      errMessage: errMessage ?? this.errMessage,
      actionStatus: actionStatus ?? this.actionStatus,
      actionMessage: actionMessage ?? this.actionMessage,
    );
  }
}
