import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerContent {
  String title;
  IconData icon;
  DrawerContent(this.title, this.icon);
}

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});
   final List<DrawerContent> items = [
    DrawerContent('Setting', Icons.settings),
    DrawerContent('Users', Icons.person),
    DrawerContent('Buck Up', Icons.backup_outlined),
    DrawerContent('Report', Icons.report_gmailerrorred),
    DrawerContent('About', Icons.account_box_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.teal[300],
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 50,
              child: Icon(Icons.local_grocery_store, size: 50,),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: ListTile(
                      shape: CircleBorder(),
                      tileColor: Colors.white,
                      leading: Icon(items[index].icon, color: Colors.orange[300],),
                      horizontalTitleGap: 40,
                      onTap: (){},
                      title: Text(items[index].title, style: TextStyle(fontSize: 20),),
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
