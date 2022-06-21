import 'package:flutter/material.dart';
import 'package:money_app/screens/category/expones_categoeryList.dart';
import 'package:money_app/screens/category/income_cateagorylist.dart';
import 'package:money_app/db/category/category_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
 
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refresUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
         tabs:const [
          Tab(
            text: 'INCOME',
          ),
          Tab(
            text: 'EXPENSE',
          )
        ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:const [
              IncomeCategoryList(),
              ExponesCategoryList()
            ]),
        )
      ],
    );
  }
}
