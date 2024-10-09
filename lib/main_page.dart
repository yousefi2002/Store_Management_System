import 'package:flutter/material.dart';
import 'package:store_ms/drawer.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'inputting_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List items = ['مخمل', 'ساتن', 'کریپ'];
  late int numberOfSales;
  late double totalAmount;
  final formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[500],
        title: Text('Store Management'),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                'Nothing sold yet',
                style: TextStyle(fontSize: 50),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.7),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                            '${now.year}-${now.month}-${now.day}',
                            style: TextStyle(fontSize: 20),
                          )),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${numberOfSales = 15}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'کل فروش',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${numberOfSales = 9000}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'کل جمع',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            color: Colors.teal[300],
                            margin: EdgeInsets.only(top: 8),
                            child: ListTile(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              leading: Text(items[index]),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
        overlayColor: Colors.white,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            child: Icon(Icons.attach_money),
            label: 'Sell',
            labelBackgroundColor: Colors.teal[300],
            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                  const MyFormPage()));
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            child: Icon(Icons.shopping_cart),
            label: 'Buy',
            labelBackgroundColor: Colors.teal[300],
            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.4,
                      maxChildSize: 0.7,
                      expand: false,
                      builder: (BuildContext context,
                          ScrollController
                          scrollController) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextField(),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Save'),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}


/*
FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.teal,
                            content: Text(
                              'Decide what to add',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                },
                                child: Text('Add Product'),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.orange[300]),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.orange[300]),
                                child: const Text('Add Sales'),
                              ),
                            ],
                          );
                        });
                  },
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
 */