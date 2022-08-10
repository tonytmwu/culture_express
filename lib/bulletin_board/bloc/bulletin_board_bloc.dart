import 'dart:async';

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
    on<QueryAllActivitiesEvent>(_processQueryAllActivitiesEvent);
  }

  _processQueryAllActivitiesEvent(event, emit) async {
    final activities = await activityRepo.queryAll();
    emit(ShowActivities(activities: activities));
  }
}
