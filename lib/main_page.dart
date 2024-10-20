import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/drawer.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:store_ms/expenses_page.dart';
import 'package:store_ms/model_classes/sell.dart';
import 'database_helper.dart';
import 'model_classes/expenses.dart';
import 'new_sell_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Sell> sales = [];
  List<Expenses> expensesItems = [];
  final now = DateTime.now();
  late int numberOfSales = sales.length;
  int count = 0;
  int totalEarnedMoney = 0;
  String mainPageDate = '';

  void _updateDateTime() {
    setState(() {
      mainPageDate = '${now.year}-${now.month}-${now.day}';
    });
  }

  Future<void> _getTotalSalesOfToday() async{
    int sales = await databaseHelper.getTotalSalesForDay(mainPageDate);
    setState(() {
      totalEarnedMoney = sales;
    });
  }

  @override
  void initState() {
    super.initState();
    updateSellList();
    _getTotalSalesOfToday();
    _updateDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[500],
        title: Text('Store Management'),
      ),
      body: sales.isEmpty
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
                            mainPageDate,
                            style: TextStyle(fontSize: 20),
                          )),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sales.length.toString(),
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
                                "$totalEarnedMoney AFs",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'جمع کل فروش',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                Expanded(
                  child: ListView.builder(
                      itemCount: sales.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            color: Colors.teal[300],
                            margin: EdgeInsets.only(top: 8),
                            child: ListTile(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              onTap: () {
                                 // databaseHelper.truncateExpensesTable();
                              },
                              title: Text(
                                  '${sales[index].productName} : ${sales[index].amount}'),
                              subtitle: Text(sales[index].price.toString()),
                              trailing: IconButton(
                                onPressed: () => _deleteSell(context, sales[index]),
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
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.white,
        overlayColor: Colors.white,
        elevation: 50,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            child: Icon(Icons.attach_money),
            label: 'Sell',
            labelBackgroundColor: Colors.teal[300],
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            onTap: () {
              navigateToInput(Sell('', '', 0, 0, ''));
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            child: const Icon(Icons.shopping_cart),
            label: 'Buy',
            labelBackgroundColor: Colors.teal[300],
            labelStyle:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ExpensesPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  void updateSellList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Sell>> sellListFuture = databaseHelper.getSalesOfToday(mainPageDate);
      sellListFuture.then((salesList) {
        setState(() {
          sales = salesList;
          count = sales.length;
          _getTotalSalesOfToday();
        });
      });
    });
  }

  void _deleteSell(BuildContext context, Sell soldProduct) async {
    var result = await databaseHelper.deleteSell(soldProduct);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Sold item got deleted',
            style: TextStyle(color: Colors.black),
          )));
      updateSellList();
      _getTotalSalesOfToday();
    }
  }

  void navigateToInput(Sell input) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NewSellPage(input)));
    if (result == true) {
      updateSellList();
      if(mainPageDate == '${now.year}-${now.month}-${now.day}'){
        _getTotalSalesOfToday();
      }
    }
  }
}
