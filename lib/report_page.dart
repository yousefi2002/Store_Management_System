import 'package:flutter/material.dart';
import 'package:store_ms/expenses_report.dart';
import 'package:store_ms/sales_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom:  PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Expanded(
                child: TabBar(
                  tabs: [
                    Tab(
                      text: 'Sales Report',
                      icon: Icon(Icons.report_outlined),
                    ),
                    Tab(
                      text: 'Expenses Report',
                      icon: Icon(Icons.monetization_on_outlined),
                    ),
                  ],
                  dividerColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: Colors.grey[400],
                ),
              ),
            ),
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            title: const Text('Report Page'),
            elevation: 0,
          ),
          body: TabBarView(
            children: [
              SalesReport(),
              ExpensesReport(),
            ],
          )),
    );
  }
}

// Future<List<Map<String, dynamic>>> getReports(DateTime startDate, DateTime endDate, String product, String user) async {
//   var db;
//   return await db.rawQuery(
//     'SELECT * FROM Transactions JOIN Products ON Transactions.productId = Products.productId '
//         'JOIN Users ON Transactions.userId = Users.userId WHERE transactionDate BETWEEN ? AND ? '
//         'AND Products.productName = ? AND Users.userName = ?',
//     [startDate.toIso8601String(), endDate.toIso8601String(), product, user],
//   );

