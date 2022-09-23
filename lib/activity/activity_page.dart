import 'package:cached_network_image/cached_network_image.dart';
import 'package:culture_express/activity/bloc/activity_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ActivityPage extends StatefulWidget {

  String id;

  ActivityPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  late ActivityBloc _bloc;
  late YoutubePlayerController _controller;
  late YoutubePlayer _player;

  _onLayoutDone(_) {
    _bloc.add(GetActivityEvent(id: widget.id));
  }

  @override
  void initState() {
    super.initState();
    _bloc = ActivityBloc();
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    initYoutubeController();
  }

  void initYoutubeController() {
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  YoutubePlayer initPlayer(String? videoId) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      topActions: <Widget>[
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            _controller.metadata.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () { },
        ),
      ],
      onReady: () {
        if(videoId != null) {
          _controller.load(videoId);
        }
      },
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<ActivityBloc, ActivityState>(
        listener: (BuildContext context, state) {  },
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (BuildContext context, state) {

            debugPrint("youtubeLink -> ${state.activity?.youtubeLink}");

            _player = initPlayer(state.activity?.youtubeLink);
            return YoutubePlayerBuilder(
              player: _player,

              builder: (BuildContext , Widget) => Scaffold(
                appBar: AppBar(
                    title: const Text("活動詳情", style: TextStyle(color: Colors.white),),
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                    )
                ),
                body: ListView(
                  padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                  children: [
                    Column(
                      children: [

                        Visibility(
                          visible: state.activity?.youtubeLink?.isNotEmpty == true,
                          child: _player,
                        ),

                        const SizedBox(height: 5,),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(state.activity?.caption ?? "", style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 5,),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(state.activity?.introduction ?? "", style: const TextStyle(fontSize: 16, color: Colors.black,),),
                        ),

                        const SizedBox(height: 5,),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text( (state.activity?.city?.isNotEmpty == true) ? "${state.activity?.city ?? ""} / ${state.activity?.venue ?? ""}" : state.activity?.venue ?? "",
                            style: const TextStyle(fontSize: 18, color: Colors.black,),),
                        ),

                        const SizedBox(height: 5,),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text("${state.activity?.startDate ?? ""} ~ ${state.activity?.endDate ?? ""}", style: const TextStyle(fontSize: 18, color: Colors.black),),
                        ),

                        const SizedBox(height: 5,),

                        Visibility(
                          visible: state.activity?.websiteLink?.isNotEmpty == true,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                child: GestureDetector(
                                  onTap: () {
                                    _launchUrl(state.activity!.websiteLink!);
                                  },
                                  child: Text(state.activity?.websiteLink ?? "" , style: const TextStyle(fontSize: 18, color: Colors.blue),),
                                ),
                              ),

                              const SizedBox(height: 5,),
                            ],
                          )),

                        Visibility(
                          visible: state.activity?.imageFile?.isNotEmpty == true,
                          child: CachedNetworkImage(
                            imageUrl: state.activity?.imageFile ?? "",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                height: 300,
                                child: const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                )
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

            );
          },),
      ),
    );
  }
}
