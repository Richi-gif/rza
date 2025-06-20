import 'package:praktikum_1/service/book/book_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;
  Future<Database> get db async => _db ??= await initDB();

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'books.db');
    return openDatabase(path, version: 1, onCreate: (db, v) {
      return db.execute('''
        CREATE TABLE books(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          author TEXT,
          description TEXT
        )
      ''');
    });
  }

  Future<int> insertBook(Book book) async {
    final dbClient = await db;
    return dbClient.insert('books', book.toMap());
  }

  Future<List<Book>> getBooks() async {
    final dbClient = await db;
    final maps = await dbClient.query('books', orderBy: 'id DESC');
    return maps.isNotEmpty ? maps.map((m) => Book.fromMap(m)).toList() : [];
  }

  Future<int> updateBook(Book book) async {
    final dbClient = await db;
    return dbClient
        .update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }

  Future<int> deleteBook(int id) async {
    final dbClient = await db;
    return dbClient.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
