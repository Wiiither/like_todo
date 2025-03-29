import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../base/constant_value.dart';
import '../entity/todo_entity.dart';
import '../entity/todo_group_entity.dart';
import '../entity/todo_tag_entity.dart';

/**
 * 数据库更新：
 * version 1:
 * - 创建表 todoGroup，todo，todoGroupMapping
 * version 2:
 * - 创建表 todoTag，
 */

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper._internal();

  factory DataBaseHelper() => _instance;

  DataBaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print('数据库地址${await getDatabasesPath()}');
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todoGroup (
        groupID TEXT PRIMARY KEY,
        groupName TEXT NOT NULL,
        isDefault INTEGER NOT NULL
      )
    ''');

    // 插入默认分组
    await db.insert('todoGroup', {
      'groupID': defaultGroupID,
      'groupName': '默认',
      'isDefault': 1,
    });

    await db.execute('''
      CREATE TABLE todo (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        mark TEXT NOT NULL,
        startTime TEXT,
        endTime TEXT,
        completeTime TEXT,
        tags TEXT,
        isCompleted INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE todoGroupMapping (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        todoID TEXT NOT NULL,
        groupID TEXT NOT NULL,
        FOREIGN KEY (todoID) REFERENCES todo (id),
        FOREIGN KEY (groupID) REFERENCES todoGroup (groupID)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE todoTag (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tagName TEXT NOT NULL,
        tagType TEXT NOT NULL
      )
    ''');
    }
  }

  //  添加 ToDo 表的增删改查方法
  Future<int> insertTodo(TodoEntity todo) async {
    final db = await database;
    return await db.insert('todo', {
      'id': todo.id,
      'title': todo.title,
      'mark': todo.mark,
      'startTime': todo.startTime?.toIso8601String(),
      'endTime': todo.endTime?.toIso8601String(),
      'completeTime': todo.completeTime?.toIso8601String(),
      'tags': todo.tags.map((tag) => tag.toString()).join(','),
      'isCompleted': todo.isCompleted ? 1 : 0,
    });
  }

  Future<List<TodoEntity>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      String tagsStr = maps[i]['tags'] as String;
      return TodoEntity(
        id: maps[i]['id'].toString(),
        title: maps[i]['title'],
        mark: maps[i]['mark'],
        startTime: maps[i]['startTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['startTime']),
        endTime: maps[i]['endTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['endTime']),
        completeTime: maps[i]['completeTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['completeTime']),
        tags: tagsStr.isEmpty
            ? []
            : tagsStr.split(',').map((tag) {
                return TodoTagEntity.fromString(tag);
              }).toList(),
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  Future<int> updateTodo(TodoEntity todo) async {
    final db = await database;
    return await db.update(
      'todo',
      {
        'title': todo.title,
        'mark': todo.mark,
        'startTime': todo.startTime?.toIso8601String(),
        'endTime': todo.endTime?.toIso8601String(),
        'completeTime': todo.completeTime?.toIso8601String(),
        'tags': todo.tags.map((tag) => tag.toString()).join(','),
        'isCompleted': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(String id) async {
    final db = await database;
    return await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 添加 todoGroup 表的增删改查方法
  Future<int> insertTodoGroup(TodoGroupEntity group) async {
    final db = await database;
    return await db.insert('todoGroup', {
      'groupID': group.groupID,
      'groupName': group.groupName,
      'isDefault': group.isDefault ? 1 : 0,
    });
  }

  Future<List<TodoGroupEntity>> getTodoGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todoGroup');
    return List.generate(maps.length, (i) {
      return TodoGroupEntity(
        groupID: maps[i]['groupID'],
        groupName: maps[i]['groupName'],
        isDefault: maps[i]['isDefault'] == 1,
      );
    });
  }

  Future<int> updateTodoGroup(TodoGroupEntity group) async {
    final db = await database;
    return await db.update(
      'todoGroup',
      {
        'groupName': group.groupName,
        'isDefault': group.isDefault ? 1 : 0,
      },
      where: 'groupID = ?',
      whereArgs: [group.groupID],
    );
  }

  Future<int> deleteTodoGroup(String groupID) async {
    final db = await database;
    return await db.delete(
      'todoGroup',
      where: 'groupID = ?',
      whereArgs: [groupID],
    );
  }

  // 添加 todoGroupMapping 表的增删改查方法
  Future<int> insertTodoGroupMapping(String todoID, String groupID) async {
    final db = await database;
    return await db.insert('todoGroupMapping', {
      'todoID': todoID,
      'groupID': groupID,
    });
  }

  Future<List<Map<String, dynamic>>> getTodoGroupMappings() async {
    final db = await database;
    return await db.query('todoGroupMapping');
  }

  Future<int> updateTodoGroupMapping(
      int id, String todoID, String groupID) async {
    final db = await database;
    return await db.update(
      'todoGroupMapping',
      {
        'todoID': todoID,
        'groupID': groupID,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTodoGroupMappingByToDoID(
      String todoID, String groupID) async {
    final db = await database;
    return await db.update(
      'todoGroupMapping',
      {
        'groupID': groupID,
      },
      where: 'todoID = ?',
      whereArgs: [todoID],
    );
  }

  Future<int> deleteTodoGroupMappingByTodo(String todoID) async {
    final db = await database;
    return await db.delete(
      'todoGroupMapping',
      where: 'todoID = ?',
      whereArgs: [todoID],
    );
  }

  Future<int> deleteTodoGroupMappingByGroup(String groupID) async {
    final db = await database;
    return await db.delete(
      'todoGroupMapping',
      where: 'groupID = ?',
      whereArgs: [groupID],
    );
  }

  Future<List<TodoEntity>> getTodosByGroup(String groupID) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT todo.* FROM todo
      INNER JOIN todoGroupMapping ON todo.id = todoGroupMapping.todoID
      WHERE todoGroupMapping.groupID = ?
    ''', [groupID]);

    return List.generate(maps.length, (i) {
      String tagsStr = maps[i]['tags'] as String;
      return TodoEntity(
        id: maps[i]['id'].toString(),
        title: maps[i]['title'],
        mark: maps[i]['mark'],
        startTime: maps[i]['startTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['startTime']),
        endTime: maps[i]['endTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['endTime']),
        completeTime: maps[i]['completeTime'] == null
            ? null
            : DateTime.tryParse(maps[i]['completeTime']),
        tags: tagsStr.isEmpty
            ? []
            : tagsStr.split(',').map((tag) {
                return TodoTagEntity.fromString(tag);
              }).toList(),
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  Future<Map<String, List<TodoEntity>>> getAllGroupTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> groupMaps = await db.query('todoGroup');
    Map<String, List<TodoEntity>> groupTodosMap = {};

    for (var group in groupMaps) {
      String groupID = group['groupID'];
      final List<Map<String, dynamic>> todoMaps = await db.rawQuery('''
        SELECT todo.* FROM todo
        INNER JOIN todoGroupMapping ON todo.id = todoGroupMapping.todoID
        WHERE todoGroupMapping.groupID = ?
      ''', [groupID]);

      List<TodoEntity> todos = List.generate(todoMaps.length, (i) {
        String tagsStr = todoMaps[i]['tags'] as String;
        return TodoEntity(
          id: todoMaps[i]['id'].toString(),
          title: todoMaps[i]['title'],
          mark: todoMaps[i]['mark'],
          startTime: todoMaps[i]['startTime'] == null
              ? null
              : DateTime.tryParse(todoMaps[i]['startTime']),
          endTime: todoMaps[i]['endTime'] == null
              ? null
              : DateTime.tryParse(todoMaps[i]['endTime']),
          completeTime: todoMaps[i]['completeTime'] == null
              ? null
              : DateTime.tryParse(todoMaps[i]['completeTime']),
          tags: tagsStr.isEmpty
              ? []
              : tagsStr.split(',').map((tag) {
                  return TodoTagEntity.fromString(tag);
                }).toList(),
          isCompleted: todoMaps[i]['isCompleted'] == 1,
        );
      });

      groupTodosMap[groupID] = todos;
    }

    return groupTodosMap;
  }

  Future<int> insertTag(TodoTagEntity tag) async {
    final db = await database;
    return await db.insert(
        'todoTag', {'tagName': tag.name, 'tagType': tag.type.toString()});
  }

  Future<int> deleteTag(TodoTagEntity tag) async {
    final db = await database;
    return await db.delete(
      'todoTag',
      where: 'tagName = ? AND tagType = ?',
      whereArgs: [tag.name, tag.type.toString()],
    );
  }

  Future<List<TodoTagEntity>> loadAllTags() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todoTag');
    return List.generate(maps.length, (i) {
      String typeType = maps[i]["tagType"];

      TodoTagEntityType type = TodoTagEntityType.values.firstWhere(
        (e) => e.toString() == typeType,
        orElse: () =>
            throw ArgumentError('Invalid TodoTagEntityType: $typeType'),
      );
      return TodoTagEntity(name: maps[i]["tagName"], type: type);
    });
  }
}
