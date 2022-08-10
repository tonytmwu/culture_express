import 'package:culture_express/activity/activity_page.dart';
import 'package:culture_express/bulletin_board/bloc/bulletin_board_bloc.dart';
import 'package:culture_express/bulletin_board/poster_view.dart';
import 'package:culture_express/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BulletinBoardPage extends StatefulWidget {
  const BulletinBoardPage({Key? key}) : super(key: key);

  @override
  State<BulletinBoardPage> createState() => _BulletinBoardPageState();
}

class _BulletinBoardPageState extends State<BulletinBoardPage> {

  late BulletinBoardBloc _bloc;

  _onLayoutDone(_) {
    _bloc.add(QueryAllActivitiesEvent());
  }

  @override
  void initState() {
    super.initState();
    _bloc = BulletinBoardBloc();
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<BulletinBoardBloc, BulletinBoardState>(
        listener: (BuildContext context, state) {  },
        child: BlocBuilder<BulletinBoardBloc, BulletinBoardState>(
          builder: (BuildContext context, state) {
            List<Activity>? activities;
            if(state is ShowActivities) {
              activities = state.activities;
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text("文化快訊"),
                centerTitle: true,
              ),
              body: ListView.separated(
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) => const SizedBox(height: 20,),
                itemCount: activities?.length ?? 0,
                itemBuilder: (context, index) {
                  final activity = activities?[index];
                  return GestureDetector(
                    onTap: () {
                      if (activity?.id != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ActivityPage(id: activity!.id!)));
                      }
                    },
                    child: PosterView(
                      img: activity?.imageFile,
                      caption: activity?.caption,
                      city: activity?.city,
                      venue: activity?.venue,
                      startData: activity?.startDate,
                      endDate: activity?.endDate,
                    ),
                  );
                },
              ),
            );
          },),
      ),
    );
  }
}
