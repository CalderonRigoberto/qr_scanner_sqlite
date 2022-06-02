import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/providers/scan_provider.dart';
import 'package:qr_scanner_sqlite/utils/utils.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code),
      onPressed: () async {
        String barCodeScanner = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF',
          'Cancelar',
          false, 
          ScanMode.QR
        );

        if ( barCodeScanner == '-1' ) {
          return;
        }
        final scanListProvider =
            Provider.of<ScanProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.newScan(barCodeScanner);
        urlLauncher(context, nuevoScan);
      },
    );
  }
}
