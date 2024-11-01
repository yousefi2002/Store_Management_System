import 'package:flutter/material.dart';
import 'package:store_ms/loan_borrow/loan_borrow_page.dart';
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
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerContent> items = [
      DrawerContent('فروشنده ها', Icons.person, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UserList(),
          ),
        );
      }),
      DrawerContent('اجناس', Icons.production_quantity_limits, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProductList(),
          ),
        );
      }),
      DrawerContent('گزارش', Icons.report_gmailerrorred, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ReportPage(),
          ),
        );
      }),
      DrawerContent('قرضه', Icons.monetization_on_outlined, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoanBorrowPage(),
          ),
        );
      }),
      DrawerContent('Backup به زودی...', Icons.backup_outlined, onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }),
      DrawerContent('تنظیمات', Icons.settings, onTap: () {
        showDialog(
          context: context,
          builder: (context) => const SettingsDialog(),
        );
      }),
      DrawerContent('درباره', Icons.account_box_outlined, onTap: () {
        showDialog(
          context: context,
          builder: (context) => const AboutPage(),
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
                    padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      tileColor: Colors.white,
                      leading: Icon(
                        items[index].icon,
                        color: Colors.orange[300],
                        ),
                        horizontalTitleGap: 40,
                        onTap: () {
                          items[index].onTap();
                        },
                        minTileHeight: 35,
                        title: Text(
                          items[index].title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}
