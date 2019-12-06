import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDb {
  static Database _database;

  static Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  /// Get the path to the local database stored on the device
  static Future<String> getDbPath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, 'data.sqlite');

    return dbPath;
  }

  static Future<void> setupDbFile() async {
    final dbPath = await getDbPath();

    if (kDebugMode) {
      try {
        await File(dbPath).delete();
      } catch (e) {
        print(e.toString());
      }
    }

    // move the database file from assets/ folder to app document directory
    // so sqflite can access it
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      final data = await rootBundle.load('assets/data/data.sqlite');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }
  }

  static Future<Database> initDB() async {
    await setupDbFile();

    final dbPath = await getDbPath();

    return await openDatabase(
      dbPath,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) {},
    );
  }
}

class SqfliteAttemptToWriteInReadonlyDatabase extends StatefulWidget {
  @override
  _SqfliteAttemptToWriteInReadonlyDatabaseState createState() =>
      _SqfliteAttemptToWriteInReadonlyDatabaseState();
}

class _SqfliteAttemptToWriteInReadonlyDatabaseState
    extends State<SqfliteAttemptToWriteInReadonlyDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                final db = await SqliteDb.database;
                final res = await db.query('Test');

                res.forEach((row) {
                  print('id ${row['id']}, name: ${row['name']}, phone: ${row['phone']}');
                });
              },
              child: Text('QUERY'),
            ),
            RaisedButton(
              onPressed: () async {
                final db = await SqliteDb.database;
                final res = await db.update('Test', { 'phone': Random().nextInt(1000000) });
                print('update successfully');
              },
              child: Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  }
}
