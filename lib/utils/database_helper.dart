import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_repeat_type.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(path, version: 3, onCreate: (db, version) async {
      await db.execute('''
       CREATE TABLE todo_entity(
            id TEXT PRIMARY KEY,
            title TEXT,
            mark TEXT,
            isCompleted INTEGER,
            type TEXT,
            startTime TEXT,
            endTime TEXT,
            isRepeat INTEGER,
            tags TEXT
       )
      ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 3) {
        print("更新表咯");
        // 创建一个新的表，添加新字段并修改字段名
        await db.execute('''
          CREATE TABLE new_todo_entity(
            id TEXT PRIMARY KEY,
            title TEXT,
            mark TEXT,
            isCompleted INTEGER,
            type TEXT,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            repeatType TEXT,
            tags TEXT
          )
        ''');

        // 复制旧表的数据到新表
        await db.execute('''
          INSERT INTO new_todo_entity (id, title, mark, isCompleted, type, startTime, endTime, tags)
          SELECT id, title, mark, isCompleted, type, startTime, endTime, tags FROM todo_entity
        ''');

        // 删除旧表
        await db.execute('DROP TABLE todo_entity');

        // 重命名新表
        await db.execute('ALTER TABLE new_todo_entity RENAME TO todo_entity');
      }
    });
  }

  // 插入数据
  Future<void> insertTodoEntity(TodoEntity todo) async {
    final db = await database;
    await db.insert(
      'todo_entity',
      {
        'id': todo.id,
        'title': todo.title,
        'mark': todo.mark,
        'isCompleted': todo.isCompleted ? 1 : 0,
        'type': todo.type.toString(),
        'date': todo.date?.toIso8601String(),
        'startTime': todo.startTime?.toIso8601String(),
        'endTime': todo.endTime?.toIso8601String(),
        'repeatType': todo.repeatType.key,
        'tags': todo.tags.map((tag) => tag.toString()).join(','),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 获取所有数据
  Future<List<TodoEntity>> getTodoEntities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo_entity');

    return List.generate(maps.length, (i) {
      String tagsStr = maps[i]['tags'] as String;

      return TodoEntity(
        id: maps[i]['id'],
        title: maps[i]['title'],
        mark: maps[i]['mark'],
        isCompleted: maps[i]['isCompleted'] == 1,
        type: TodoEntityType.values
            .firstWhere((e) => e.toString() == maps[i]['type']),
        date: maps[i]['date'] != null ? DateTime.parse(maps[i]['date']) : null,
        startTime: maps[i]['startTime'] != null
            ? DateTime.parse(maps[i]['startTime'])
            : null,
        endTime: maps[i]['endTime'] != null
            ? DateTime.parse(maps[i]['endTime'])
            : null,
        repeatType:
            TodoRepeatType.findDefaultTypeWithKey(maps[i]['repeatType']) ??
                TodoRepeatType.defaultRepeatType[0],
        tags: tagsStr.isEmpty
            ? []
            : tagsStr.split(',').map((tag) {
                return TodoTagEntity.fromString(tag);
              }).toList(),
      );
    });
  }

  // 更新数据
  Future<void> updateTodoEntity(TodoEntity todo) async {
    final db = await database;
    await db.update(
      'todo_entity',
      {
        'title': todo.title,
        'mark': todo.mark,
        'isCompleted': todo.isCompleted ? 1 : 0,
        'type': todo.type.toString(),
        'date': todo.date?.toIso8601String(),
        'startTime': todo.startTime?.toIso8601String(),
        'endTime': todo.endTime?.toIso8601String(),
        'repeatType': todo.repeatType.key,
        'tags': todo.tags.map((tag) => tag.toString()).join(','),
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // 删除数据
  Future<void> deleteTodoEntity(String id) async {
    final db = await database;
    await db.delete(
      'todo_entity',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
