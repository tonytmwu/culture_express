part of 'activity_bloc.dart';

@immutable
abstract class ActivityState extends Equatable {

  Activity? activity;

  @override
  List<Object?> get props => [activity];
}

class ActivityInitial extends ActivityState {}

class GetActivityDoneState extends ActivityState {

  @override Activity? activity;

  GetActivityDoneState({required this.activity});

}
