import 'package:culture_express/api/http_service.dart';
import 'package:culture_express/db/SqlHelper.dart';
import 'package:culture_express/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ActivityRepo {

  final httpService = HttpService(host: Uri.https("cultureexpress.taipei", "/").toString());

  Future<bool> fetchActivityList() async{
    final response = await httpService.request(HttpMethod.get, path: "OpenData/Event/C000003");
    final list = response?.data as List<dynamic>?;
    bool isOK = await saveData(list);
    return isOK;
  }

  Future<bool> saveData(List<dynamic>? activities) async {
    try {
      final batch = SqlHelper.db.batch();
      activities?.forEach((activity) {
          final json = activity as Map<String, dynamic>;
          batch.insert('activity', json, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      await batch.commit();
      debugPrint("save done!");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<Activity>> queryAll() async {
    List<Map> list = await SqlHelper.db.rawQuery('SELECT * FROM activity');
    List<Activity> activities = [];
    for (var item in list) {
      final json = item as Map<String, dynamic>;
      activities.add(Activity.fromJson(json));
    }
    return activities;
  }

  Future<Activity?> queryActivityById(String id) async {
    List<Map> list = await SqlHelper.db.query("activity",
        columns: ["Caption", "City", "Company", "StartDate", "EndDate", "Introduction", "ImageFile", "Venue", "Introduction", "YoutubeLink", "WebsiteLink"],
        where: 'ID = ?',
        whereArgs: [id]);

    Activity? activity;
    if(list.isNotEmpty) {
      final json = list[0] as Map<String, dynamic>;
      activity = Activity.fromJson(json);
    }
    return activity;
  }

  Future<List<String>> queryCities() async {
    List<Map<String, dynamic>> list = await SqlHelper.db.rawQuery("SELECT DISTINCT City FROM activity");
    debugPrint(list.toString());
    List<String> cities = ["全部"];
    if(list.isNotEmpty) {
      for (Map<String, dynamic> element in list) {
        String? city = element["City"];
        if(city?.isNotEmpty == true) {
          cities.add(city!);
        }
      }
    }
    return cities;
  }

  Future<List<Activity>> queryActivityByCity(String city) async {
    List<Map> list = await SqlHelper.db.query("activity",
        columns: ["ID", "Caption", "City", "Company", "StartDate", "EndDate", "Introduction", "ImageFile", "Venue", "Introduction", "YoutubeLink", "WebsiteLink"],
        where: 'City = ?',
        whereArgs: [city]);

    List<Activity> activities = [];
    for (var item in list) {
      final json = item as Map<String, dynamic>;
      activities.add(Activity.fromJson(json));
    }
    return activities;
  }
}