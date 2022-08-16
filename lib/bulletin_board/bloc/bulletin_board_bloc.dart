import 'package:bloc/bloc.dart';
import 'package:culture_express/model/activity.dart';
import 'package:culture_express/repository/activity_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bulletin_board_event.dart';
part 'bulletin_board_state.dart';

class BulletinBoardBloc extends Bloc<BulletinBoardEvent, BulletinBoardState> {

  final activityRepo = ActivityRepo();

  BulletinBoardBloc() : super(BulletinBoardInitial()) {
    on<InitBulletinBoardEvent>(_processBulletinBoardInitial);
    on<QueryAllActivitiesEvent>(_processActivitiesEvent);
    on<QueryActivitiesByCityEvent>(_processActivitiesEvent);
  }

  _processBulletinBoardInitial(event, emit) async {
    final cities = await activityRepo.queryCities();
    emit(BulletinBoardInitial(cities: cities));
  }

  _processActivitiesEvent(event, emit) async {
    switch (event.runtimeType) {
      case QueryActivitiesByCityEvent:
        final city = (event as QueryActivitiesByCityEvent).city;
        List<Activity>? activities;
        if("全部" == city) {
          activities = await activityRepo.queryAll();
        } else {
          activities = await activityRepo.queryActivityByCity(city);
        }
        emit(ShowActivities(activities: activities));
        break;
      default:
        final activities = await activityRepo.queryAll();
        emit(ShowActivities(activities: activities));
        break;
    }
  }
}
