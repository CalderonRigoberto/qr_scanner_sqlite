import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';

void urlLauncher(BuildContext context, ScanModel scan) async {
    if (scan.tipo == 'http') {
      final url = Uri.parse(scan.valor);
      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        print("Can't launch $url");
      }
    } else {
      Navigator.pushNamed(context, 'map', arguments: scan);
    }
  }