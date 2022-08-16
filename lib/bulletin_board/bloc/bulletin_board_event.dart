part of 'bulletin_board_bloc.dart';

@immutable
abstract class BulletinBoardEvent {}

class QueryAllActivitiesEvent extends BulletinBoardEvent {}

class InitBulletinBoardEvent extends BulletinBoardEvent {

  InitBulletinBoardEvent();
}

class QueryActivitiesByCityEvent extends BulletinBoardEvent {

  String city;

  QueryActivitiesByCityEvent({required this.city});

}
