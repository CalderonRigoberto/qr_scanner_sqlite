import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_scanner_sqlite/models/scan_model.dart';
export 'package:qr_scanner_sqlite/models/scan_model.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Path donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File file = File('${documentsDirectory.path}/ScansDB.db');

    //Imprimir path donde se encuentra la base de datos
    print(file);

    //Abrir la pase de datos.
    return await openDatabase(file.toString(), version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

//Crear registros en base de datos, de manera más larga
  newScanRaw(ScanModel newScan) async {
    //Valores de ScanModel
    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    //Verificar la base datos
    final db = await database;

    final response = await db.rawQuery('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES  ($id, '$tipo', '$valor')
      ''');

    return response;
  }

  //Registrar datos en la bd, de manera más sencilla
  newScan(ScanModel newScan) async {
    final db = await database;
    final response = db.insert('Scans', newScan.toJson());
    print(response);
    return response;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    final response = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  getScans() async {
    final db = await database;

    final response = await db.query('Scans');
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  getScansByType(String tipo) async {
    final db = await database;

    final response = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
  ''');
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  updateScan(ScanModel updateScan) async {
    final db = await database;
    final response = await db.update('Scans', updateScan.toJson(),
        where: 'id = ?', whereArgs: [updateScan.id]);
    return response;
  }

  deleteById(int id) async {
    final db = await database;
    final response = db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  deleteAll() async {
    final db = await database;
    final response = db.rawDelete('''
      DELETE FROM Scans 
    ''');
  }
}
