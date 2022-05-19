import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflitedemo/app/data/provider/list_data_model.dart';

class FavoriteDatabase {
  ///making instance for call constructor
  static final FavoriteDatabase instance = FavoriteDatabase._init();

  static Database? _database;

  ///private constructor
  FavoriteDatabase._init();

  ///open database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorites.db');
    return _database!;
  }

  //initialize our database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

 print("-->>");
    print('''
    CREATE TABLE $tableFavorites (
    ${FavoriteFields.id} $idType,
    ${FavoriteFields.imageUrl} $textType,
    ${FavoriteFields.stramUrl} $textType,
    ${FavoriteFields.chName} $textType,
    ${FavoriteFields.description} $textType,
    ${FavoriteFields.viewing} $textType,
    ${FavoriteFields.isFav} $boolType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableFavorites (
    ${FavoriteFields.id} $idType,
    ${FavoriteFields.imageUrl} $textType,
    ${FavoriteFields.stramUrl} $textType,
    ${FavoriteFields.chName} $textType,
    ${FavoriteFields.description} $textType,
    ${FavoriteFields.viewing} $textType,
    ${FavoriteFields.isFav} $boolType
    )
    ''');

    // String sql = "CREATE TABLE " + tableFavorites + " ("
    // +FavoriteFields.id+" "+idType+", "
    // +FavoriteFields.imageUrl+" "+textType+", "
    // +FavoriteFields.stramUrl+" "+textType+", "
    // +FavoriteFields.chName+" "+textType+", "
    // +FavoriteFields.description+" "+textType+", "
    // +FavoriteFields.viewing+" "+textType+", "
    // +FavoriteFields.isFav+" "+boolType+""
    // +");"
    // ;
    // await db.execute(sql);
    print("created");
  }

  Future<Datum> create(Datum datum) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorites, datum.toJson());

    print("inserted");
    return datum.copy(id: id);
  }

  Future<Datum> readFavorite(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: FavoriteFields.values,
      where: '${FavoriteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Datum.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Datum>> readAllFavorites() async {
    final db = await instance.database;

    final orderByq = '${FavoriteFields.chName} ASC';

    // final rawqresult = await db.rawQuery('SELECT * FROM $tableFavorites ORDER BY $orderByq');

    final result = await db.query(tableFavorites, orderBy: orderByq);

    print("read");
    return result.map((json) => Datum.fromJson(json)).toList();
  }

  Future<int> update(Datum datum) async {
    final db = await instance.database;

    return db.update(tableFavorites, datum.toJson(),
        where: '${FavoriteFields.id} = ?', whereArgs: [datum.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(tableFavorites,
        where: '${FavoriteFields.id} = ?', whereArgs: [id]);
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
