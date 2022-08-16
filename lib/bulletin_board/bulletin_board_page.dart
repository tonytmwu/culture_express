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

  List<String>? cities;
  late BulletinBoardBloc _bloc;

  _onLayoutDone(_) {
    _bloc.add(InitBulletinBoardEvent());
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
        listener: (BuildContext context, state) {
          if(state is BulletinBoardInitial) {
            cities = state.cities;
          }
        },
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
              body: Column(
                children: <Widget> [

                  const SizedBox(height: 5,),

                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cities?.length ?? 0,
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),
                      itemBuilder: (BuildContext context, int index) {
                        return _createCityText(cities?[index] ?? "", () {
                          _bloc.add(QueryActivitiesByCityEvent(city: cities?[index] ?? ""));
                        });
                      },)),

                  const SizedBox(height: 5,),

                  Expanded(
                    flex: 18,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                              startDate: activity?.startDate,
                              endDate: activity?.endDate,
                            ),
                          );
                        },
                      ))
                ],
              ),
            );
          },),
      ),
    );
  }

  Widget _createCityText(String city, VoidCallback action) {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.green.shade400, width: 1,)
      ),
      child: GestureDetector(
        onTap: action,
        child: Text(city, style: const TextStyle(fontSize: 14),),
      ),
    );
  }

}
