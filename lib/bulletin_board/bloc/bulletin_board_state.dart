part of 'bulletin_board_bloc.dart';

@immutable
abstract class BulletinBoardState extends Equatable {

  List<Activity>? activities;

  @override
  List<Object?> get props => [activities];
}

class BulletinBoardInitial extends BulletinBoardState {

  List<String>? cities;

  BulletinBoardInitial({this.cities});

}

class ShowActivities extends BulletinBoardState {

  @override
  List<Activity>? activities;

  ShowActivities({required this.activities});
}
