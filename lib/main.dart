import 'package:bloc/bloc.dart';
import 'package:culture_express/bulletin_board/bulletin_board_page.dart';
import 'package:culture_express/db/SqlHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'SimpleBlocObserver.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    await _initDB();
  }

  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

Future _initDB() async {
  await SqlHelper.initDB();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void dispose() {
    SqlHelper.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const BulletinBoardPage();
  }
}
