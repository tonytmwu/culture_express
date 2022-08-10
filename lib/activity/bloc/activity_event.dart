part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class GetActivityEvent extends ActivityEvent {

  String? id;

  GetActivityEvent({required this.id});
}
