import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_sqlite/pages/links_page.dart';
import 'package:qr_scanner_sqlite/pages/maps_page.dart';
import 'package:qr_scanner_sqlite/providers/option_provider.dart';
import 'package:qr_scanner_sqlite/widgets/custom_bottom_bar.dart';
import 'package:qr_scanner_sqlite/widgets/custom_floating_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<OptionSelected>(context);
    final currentIndex = uiProvider.selectedMenuOption;
    switch (currentIndex) {
      case 0:
        return const MapsPage();
      case 1:
        return const LinksPage();
      default:
        return const MapsPage();
    }
  }
}
