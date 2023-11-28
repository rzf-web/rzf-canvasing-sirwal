import 'package:rzf_canvasing_sirwal/services/sql/sql_helper.dart';

class SqlQuery {
  static const createSupplierTB = """
      CREATE TABLE IF NOT EXISTS ${SqlHelper.tbSupplier}(
        user_id VARCHAR(100) NOT NULL,
        supplier_id VARCHAR(100) NOT NULL,
        name VARCHAR(100) NOT NULL,
        address VARCHAR(100) NOT NULL,
        phone VARCHAR(100) NOT NULL,
        contact VARCHAR(100) NOT NULL,
        rekening VARCHAR(100) NOT NULL
      )
  """;
  static const createTypeTB = """
      CREATE TABLE IF NOT EXISTS ${SqlHelper.tbType}(
        type_name VARCHAR(100) NOT NULL
      )
  """;
  static const createCategoryTB = """
      CREATE TABLE IF NOT EXISTS ${SqlHelper.tbCategory}(
        category_name VARCHAR(100) NOT NULL
      )
  """;
  static const createRackTB = """
      CREATE TABLE IF NOT EXISTS ${SqlHelper.tbRack}(
        rak VARCHAR(100) NOT NULL
      )
  """;
  static const createUnitTB = """
      CREATE TABLE IF NOT EXISTS ${SqlHelper.tbUnit}(
        unit_name VARCHAR(100) NOT NULL
      )
  """;
}
