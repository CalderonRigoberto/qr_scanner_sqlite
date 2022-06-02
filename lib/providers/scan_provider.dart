import 'package:flutter/material.dart';
import 'package:qr_scanner_sqlite/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> newScan(String valor) async {
    //Creamos instancia de modelo
    final scan = ScanModel(valor: valor);
    //Insertamos la instancia
    final id = await DbProvider.db.newScan(scan);
    scan.id = id;
    //Añadimos a la lista
    if (tipoSeleccionado == scan.tipo || 'geo' == scan.tipo) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  loadScans() async {
    final scansDb = await DbProvider.db.getScans();
    scans = [...scansDb];
    notifyListeners();
  }

  loadScansByType(String tipo) async {
    final scansDb = await DbProvider.db.getScansByType(tipo);
    scans = [...scansDb];
    notifyListeners();
  }

  deleteAllScans() async {
    await DbProvider.db.deleteAll();
    scans = [];
    notifyListeners();
  }

  deleteScanById(ScanModel scan) async {
    await DbProvider.db.deleteById(scan.id!);
    notifyListeners();
    loadScansByType(scan.tipo!);
  }
}
