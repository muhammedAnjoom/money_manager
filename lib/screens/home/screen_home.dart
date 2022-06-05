import 'package:flutter/material.dart';
import 'package:money_app/screens/category/screen_cateagory.dart';
import 'package:money_app/screens/home/widget/bottom_navigation.dart';
import 'package:money_app/screens/transctions/screen_transtion.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTranstions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 233, 233),
      appBar: AppBar(
        title: Text('MONEY MANAGEMENT'),
        centerTitle: true,
      ),
      bottomNavigationBar: MoneyMangerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext ctx, int upadteItem, _) {
              return _pages[upadteItem];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('transtion');
          } else {
            print('category');
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
