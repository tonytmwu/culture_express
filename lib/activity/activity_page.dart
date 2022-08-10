import 'package:culture_express/activity/bloc/activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityPage extends StatefulWidget {

  String id;

  ActivityPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  late ActivityBloc _bloc;

  _onLayoutDone(_) {
    _bloc.add(GetActivityEvent(id: widget.id));
  }

  @override
  void initState() {
    super.initState();
    _bloc = ActivityBloc();
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<ActivityBloc, ActivityState>(
        listener: (BuildContext context, state) {  },
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (BuildContext context, state) {
            debugPrint("activity -> ${state.activity?.caption}");
            return Scaffold(
              appBar: AppBar(
                title: const Text("活動詳情"),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back_ios_new,),
                )
              ),
              body: ListView(
                padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(state.activity?.caption ?? "", style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                      ),

                      const SizedBox(height: 5,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(state.activity?.introduction ?? "", style: const TextStyle(fontSize: 16, color: Colors.black,),),
                      ),
                    ],
                  )
                ],
              ),
            );
          },),
      ),
    );
  }
}
