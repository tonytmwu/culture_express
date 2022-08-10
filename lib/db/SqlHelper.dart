import 'package:culture_express/db/app_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlHelper {

  static Database? _db;
  static Database db = _db!;

  // ID, Category, Caption, Company, StartDate, EndDate, TicketType, TicketPrice, TicketPurchaseLink, ContactPerson, ContactTel, Introduction, WebsiteLink, YoutubeLink, ImageFile, CreateDate, Venue, SessionStartDate, SessionEndDate, City, Area, Address, Longitude, Latitude, RelatedLink

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return _db ??= await openDatabase(
      join(dbPath, 'activity.sqlite'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE activity(ID TEXT PRIMARY KEY, Category TEXT, Caption TEXT, '
              'Company TEXT, StartDate TEXT, EndDate TEXT, TicketType TEXT, TicketPrice TEXT, TicketPurchaseLink TEXT, '
              'ContactPerson TEXT, ContactTel TEXT, Introduction TEXT, WebsiteLink TEXT, YoutubeLink TEXT, ImageFile TEXT, '
              'CreateDate TEXT, Venue TEXT, SessionStartDate TEXT, SessionEndDate TEXT, City TEXT, Area TEXT, Address TEXT, '
              'Longitude TEXT, Latitude TEXT, RelatedLink TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future closeDB() async => await _db?.close();
}