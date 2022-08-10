import 'package:sqflite/sqflite.dart';

class AppDB {
  static final AppDB _instance = AppDB._internal();

  Database? _db;

  AppDB._internal();

  factory AppDB() {
    return _instance;
  }
}