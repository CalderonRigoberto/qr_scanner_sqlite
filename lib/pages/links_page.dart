import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/providers/scan_provider.dart';
import 'package:qr_scanner_sqlite/widgets/scan_tiles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';
import '../utils/utils.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  final scansProvider = Provider.of<ScanProvider>(context, listen: true);
    final scans = scansProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection dismissDirection) {
                scansProvider.deleteScanById(scans[index]);
              },
              child: ListTile(
                leading: Icon(Icons.link ,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[index].valor),
                subtitle: Text(scans[index].id.toString()),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () async {
                  urlLauncher(context, scans[index]);
                },
              ),
            ));
  }

  
  }
  

