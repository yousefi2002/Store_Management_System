import 'package:flutter/material.dart';
import 'package:store_ms/expenses_list.dart';
import 'package:store_ms/main_page.dart';
import 'package:store_ms/product_list.dart';
import 'package:store_ms/report_page.dart';
import 'package:store_ms/settingDialog.dart';
import 'package:store_ms/user_list.dart';

import 'about_page.dart';

class DrawerContent {
  String title;
  IconData icon;
  Function onTap;
  DrawerContent(this.title, this.icon, {required this.onTap});
}

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerContent> items = [
      DrawerContent('Setting', Icons.settings, onTap: () {
        showDialog(
          context: context,
          builder: (context) => SettingsDialog(),
        );
      }),
      DrawerContent('Users', Icons.person, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserList(),
          ),
        );
      }),
      DrawerContent('Product', Icons.production_quantity_limits, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductList(),
          ),
        );
      }),
      DrawerContent('Report', Icons.report_gmailerrorred, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReportPage(),
          ),
        );
      }),
      DrawerContent('Buck Up', Icons.backup_outlined, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      }),
      DrawerContent('Expenses Report', Icons.exposure_neg_1_sharp, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpensesList(),
          ),
        );
      },),
      DrawerContent('About', Icons.account_box_outlined, onTap: () {
        showDialog(
          context: context,
          builder: (context) => AboutPage(),
        );
      },),
    ];
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.teal[300],
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 50,
              child: Icon(
                Icons.local_grocery_store,
                size: 50,
                color: Colors.orange[300],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        tileColor: Colors.white,
                        leading: Icon(
                          items[index].icon,
                          color: Colors.orange[300],
                        ),
                        horizontalTitleGap: 40,
                        onTap: () {
                          items[index].onTap();
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) =>  items[index].onTap)
                          // );
                        },
                        title: Text(
                          items[index].title,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
