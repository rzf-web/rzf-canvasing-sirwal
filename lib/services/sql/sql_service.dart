import 'package:rzf_canvasing_sirwal/services/sql/sql_helper.dart';
import 'package:rzf_canvasing_sirwal/services/sql/sql_query.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlService {
  static Future<sql.Database> getDatabase() async {
    final db = await sql.openDatabase(SqlHelper.dbName);
    return db;
  }

  static Future<void> createTables() async {
    var database = await getDatabase();
    await database.transaction((txn) async {
      await txn.execute(SqlQuery.createSupplierTB);
      await txn.execute(SqlQuery.createTypeTB);
      await txn.execute(SqlQuery.createCategoryTB);
      await txn.execute(SqlQuery.createRackTB);
      await txn.execute(SqlQuery.createUnitTB);
    });
  }

  static Future<void> clearDataTable(String tb) async {
    var database = await getDatabase();
    await database.execute("delete from $tb");
  }

  static Future<bool> dbTransaction(
    Future<void> Function(sql.Transaction) transaction,
  ) async {
    try {
      final db = await getDatabase();
      await db.transaction(transaction);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getData(
    String tbName, {
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? orderBy,
    String? having,
    int? limit,
  }) async {
    try {
      final db = await getDatabase();
      var data = await db.query(
        tbName,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
      );
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addData(
    String tbName,
    Map<String, dynamic> values,
  ) async {
    try {
      final db = await getDatabase();
      await db.insert(
        tbName,
        values,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<bool> updateData(
    String tbName,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await getDatabase();
      await db.update(
        tbName,
        values,
        where: where,
        whereArgs: whereArgs,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteData(
    String tbName, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final db = await getDatabase();
      await db.delete(
        tbName,
        where: where,
        whereArgs: whereArgs,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
