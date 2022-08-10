import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:culture_express/model/activity.dart';
import 'package:culture_express/repository/activity_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {

  final activityRepo = ActivityRepo();

  ActivityBloc() : super(ActivityInitial()) {
    on<GetActivityEvent>(_getActivity);
  }

  void _getActivity(event, emit) async {
    if(event is GetActivityEvent && event.id != null) {
      final activity = await activityRepo.queryActivityById(event.id!);
      emit(GetActivityDoneState(activity: activity));
    }
  }
}
